{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (pkgs.writeShellScriptBin "backup-android-pixel-high.sh" ''
            IP="$1" && [ -z "$IP" ] && echo "Please specify the IP." && exit 0
            ${config.ethorbit.pkgs.script.mount-sshfs-run-service}/bin/mount-sshfs-run-service.sh \
                --host android_pixel_high \
                --ip "$IP" \
                --remote-dir ./ \
                --mount-dir "$HOME/mnt/android_pixel_high" \
                --service-name restic-backups-android-pixel-high.service \
                --system-service
        '')

        (pkgs.writeShellScriptBin "upload-android-pixel-high-to-filenio.sh" ''
            FILEN_MOUNT_PATH="$HOME/mnt/filen.io"

            if [ ! $(findmnt "$FILEN_MOUNT_PATH") ]; then
                if [ $(findmnt Filen) ]; then
                    echo "Filen is already mounted elsewhere, unmount it first."
                    exit 0
                fi

                (
                    nohup "${config.ethorbit.pkgs.node.filen-cli}/bin/filen" \
                    mount "$FILEN_MOUNT_PATH" / > /dev/null 2>&1 &
                )
            fi

            if [[ $("${config.ethorbit.pkgs.script.mount-wait}/bin/mount-wait.sh" "$FILEN_MOUNT_PATH" 5) ]]; then
                LOCAL_REPO_PATH="${config.services.restic.backups."android-pixel-high".repository}"
                FILEN_REPO_PATH="''${FILEN_MOUNT_PATH}/Restic-Repos/android-high"

                export RESTIC_PASSWORD_FILE="${config.services.restic.backups."android-pixel-high".passwordFile}"
                export RESTIC_FROM_PASSWORD_FILE="$RESTIC_PASSWORD_FILE"

                if [ ! -d "$LOCAL_REPO_PATH" ]; then
                    echo "Local repo path $LOCAL_REPO_PATH doesn't exist."
                    exit 1
                fi

                if [ ! -d "$FILEN_REPO_PATH" ]; then
                    echo "Filen repo path $FILEN_REPO_PATH doesn't exist."
                    exit 1
                fi

                if [ ! -f "$RESTIC_PASSWORD_FILE" ]; then
                    echo "The password file $PASSWORD_FILE doesn't exist"
                    exit 1
                fi

                echo "Copying $LOCAL_REPO_PATH to $FILEN_REPO_PATH..."
                restic -r "$FILEN_REPO_PATH" copy --from-repo "$LOCAL_REPO_PATH" && echo "Done!"
            else
                echo "Never found a mount."
            fi
        '')
    ];
}
