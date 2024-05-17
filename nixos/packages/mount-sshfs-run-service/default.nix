# How it works:
# 1. Add the SSH connection details such as key file, port #, etc for the desired hosts to the .ssh/config of the user intended to run the script
# 2. Create a script in your system that sends the correct parameters to this script
# End result: SSHFS is automatically mounted and the desired service is then executed, if the service acts on the mount then it should be a seamless experience.
# Purpose: allowing backup solutions such as Restic to work over sshfs without the repetitiveness of having to mount SSHFS, run the backup service, view logs, then unmount
#
# While you technically could use Rclone, Rclone wants a static IP, so with a constantly changing IP you'd need to constantly edit the Rclone config's address
# This script was made with the assumption that the IP may have already changed and expects the IP to be passed as an argument.

{ config, lib, pkgs, ... }:

let
    helpText = pkgs.writeText "help-file" ''
        -h|--host
            The hostname

        --ip
            The IP address

        -r|--remote-dir
            The remote directory path that SSHFS will mount from

        -m|--mount-dir
            The directory path of where the SSHFS mount will be created

        --sshfs-extra
            The extra arguments to pass to the SSHFS command this script executes. Note: if SSHFS has already been mounted, the command won't run.

        -s|--service-name
            The name of the systemd service to start after the sshfs mount has been created

        --user-service
            Indicates that the systemd service runs as the user

        --system-service
            Indicates that the systemd service runs as the system
    '';
in
{
    options = with lib; with pkgs; {
        ethorbit.pkgs.mount-sshfs-run-service = mkOption {
            type = types.package;
            default = pkgs.writeShellScriptBin "mount-sshfs-run-service.sh" ''
            ALREADY_MOUNTED=0
            SSHFS_EXTRA=

            while [[ $# -gt 0 ]]; do    
                case $1 in
                    -h|--host)
                        HOST="$2"
                        shift
                        shift
                    ;;
                    --ip)
                        IP="$2"
                        shift
                        shift
                    ;;
                    -r|--remote-dir)
                        REMOTE_DIR="$2"
                        shift
                        shift
                    ;;
                    -m|--mount-dir)
                        MOUNT_DIR="$2"
                        shift
                        shift
                    ;;
                    --sshfs-extra)
                        SSHFS_OPTIONS="$2"
                        shift
                        shift
                    ;;
                    -s|--service-name)
                        SERVICE_NAME="$2"
                        shift
                        shift
                    ;;
                    --user-service)
                        [ -s "$SERVICE_NEEDS_ROOT" ] && echo "SERVICE_NEEDS_ROOT was already set" && exit 1
                        SERVICE_NEEDS_ROOT=0
                        shift
                    ;;
                    --system-service)
                        [ -s "$SERVICE_NEEDS_ROOT" ] && echo "SERVICE_NEEDS_ROOT was already set" && exit 1
                        SERVICE_NEEDS_ROOT=1
                        shift
                    ;;
                    *)
                        cat ${helpText.outPath}
                        exit 0
                    ;;
                esac
            done

            if [ -z "$IP" ]; then
                echo "You need to specify --ip"
                exit 1
            fi

            if [ -z "$HOST" ]; then
                echo "You need to specify --host"
                exit 1
            fi

            if [ -z "$REMOTE_DIR" ]; then
                echo "You need to specify --remote-dir"
                exit 1
            fi

            if [ -z "$MOUNT_DIR" ]; then
                echo "You need to specify --mount-dir"
                exit 1
            fi

            if [ -z "$SERVICE_NAME" ]; then
                echo "You need to specify --service-name"
                exit 1
            fi

            if [ -z "$SERVICE_NEEDS_ROOT" ]; then
                echo "You need to specify either --user-service or --system-service"
                exit 1
            fi

            # Mount if it's not mounted yet.
            mkdir -p "$MOUNT_DIR"

            if [[ ! $(findmnt "$MOUNT_DIR" | grep fuse.sshfs) ]]; then
                ${pkgs.sshfs}/bin/sshfs "$HOST"@"$IP":"$REMOTE_DIR" "$MOUNT_DIR" $SSHFS_EXTRA

                if [ $? -ne 0 ]; then
                    echo "The SSHFS failed to mount, try again."
                    exit 1
                fi
            else
                ALREADY_MOUNTED=1
            fi

            # Cleanup when closed
            close_out() {
                if [ "$SERVICE_NEEDS_ROOT" -eq 1 ]; then
                    sudo systemctl stop "$SERVICE_NAME"
                else
                    systemctl --user stop "$SERVICE_NAME"
                fi

                [ "$ALREADY_MOUNTED" -eq 0 ] && umount "$MOUNT_DIR" && echo "Unmounted."
            }

            trap close_out EXIT

            if [ "$SERVICE_NEEDS_ROOT" -eq 1 ]; then
                sudo systemctl start "$SERVICE_NAME" &
                sudo journalctl -fu "$SERVICE_NAME" && close_out
            else
                systemctl --user start "$SERVICE_NAME" &
                journalctl -fu "$SERVICE_NAME" && close_out
            fi
            '';
        };
    };
}
