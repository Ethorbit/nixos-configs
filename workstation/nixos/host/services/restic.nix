{ config, pkgs, ... }:

{
    age.secrets."nixos/restic/repos/workstation/pass" = { file = ../../../../nixos/secrets/restic/repos/workstation/pass.age; };
    age.secrets."nixos/restic/repos/main_os_storage/pass" = { file = ../../../../nixos/secrets/restic/repos/main_os_storage/pass.age; };
    age.secrets."nixos/restic/repos/android_pixel_u12/pass" = { file = ../../../../nixos/secrets/restic/repos/android_pixel_u12/pass.age; };

    environment.etc."restic_workstation_pass" = {
        mode = "0600";
        user = "root";
        source = config.age.secrets."nixos/restic/repos/workstation/pass".path;
    };

    environment.etc."restic_main_os_storage_pass" = {
        mode = "0600";
        user = "root";
        source = config.age.secrets."nixos/restic/repos/main_os_storage/pass".path;
    };

    environment.etc."restic_android_pixel_u12_pass" = {
        mode = "0600";
        user = config.ethorbit.users.primary.username;
        source = config.age.secrets."nixos/restic/repos/android_pixel_u12/pass".path;
    };

    services.restic = {
        backups = {
            "system" = {
                user = "root";
                initialize = true;
                paths = [ "/home" ];
                repository = "/mnt/homenas/Restic_Backups/workstation";
                passwordFile = "/etc/restic_workstation_pass";
                timerConfig = {
                    OnCalendar = "daily";
                    Persistent = true;
                };
                exclude = [
                    "/home/${config.ethorbit.users.primary.username}/mnt"
                ];
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            "storage" = {
                user = "root";
                initialize = true;
                paths = [ "/mnt/storage" ];
                repository = "/mnt/homenas/Restic_Backups/main_os_storage";
                passwordFile = "/etc/restic_main_os_storage_pass";
                timerConfig = {
                    OnCalendar = "weekly";
                    Persistent = true;
                };
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };

            "android-pixel-u12" = {
                user = config.ethorbit.users.primary.username;
                initialize = true;
                paths = [ "/home/${config.ethorbit.users.primary.username}/mnt/android_pixel_u12" ];
                repository = "/mnt/homenas/Restic_Backups/android_pixel_u12";
                passwordFile = "/etc/restic_android_pixel_u12_pass";
                extraBackupArgs = [
                    "--compression=max"
                    "--verbose=2"
                    "--one-file-system=true"
                ];
            };
        };
    };

    # The android backup service relies on an SSH file mount, so to avoid having to mount it 
    # every time we want to do a backup, this script will automate the process (mount + start backup)
    # So just run this script instead of the service.
    environment.systemPackages = with pkgs; [
        (pkgs.writeShellScriptBin "backup-android-pixel-u12.sh" ''
            IP="$1"
            ALREADY_MOUNTED=0

            if [ -z "$IP" ]; then
                echo "You need to pass the IP as the argument."
                exit 1
            fi

            # Mount if it's not mounted yet.
            mkdir -p ~/mnt/android_pixel_u12

            if [[ ! $(findmnt ~/mnt/android_pixel_u12/ | grep fuse.sshfs) ]]; then
                sshfs u12_a215@"$IP":./ ~/mnt/android_pixel_u12

                if [ $? -ne 0 ]; then
                    echo "The SSHFS failed to mount, try again."
                    exit 1
                fi
            else
                ALREADY_MOUNTED=1
            fi

            # Cleanup when closed
            close_out() {
                sudo systemctl stop restic-backups-android-pixel-u12.service
                [ $ALREADY_MOUNTED -eq 0 ] && umount ~/mnt/android_pixel_u12 && echo "Unmounted."
            }

            trap close_out EXIT

            sudo systemctl start restic-backups-android-pixel-u12.service &
            sudo journalctl -fu restic-backups-android-pixel-u12.service && close_out
        '')
    ];
}
