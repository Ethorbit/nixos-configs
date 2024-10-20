{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (pkgs.writeShellScriptBin "backup-android-pixel-primary.sh" ''
            IP="$1" && [ -z "$IP" ] && echo "Please specify the IP." && exit 0
            ${config.ethorbit.pkgs.script.mount-sshfs-run-service}/bin/mount-sshfs-run-service.sh \
                --host android_pixel_primary \
                --ip "$IP" \
                --remote-dir ./ \
                --mount-dir "$HOME/mnt/android_pixel_primary" \
                --service-name restic-backups-android-pixel-primary.service \
                --system-service
        '')

        (pkgs.writeShellScriptBin "sync-android-pixel-primary.sh" ''
            IP="$1" && [ -z "$IP" ] && echo "Please specify the IP." && exit 0
            # Music
            rsync -aP \
                --no-perms --no-owner --no-group \
                --itemize-changes \
                --delete-during \
                "$HOME/Music/Mp3 Player/" android_pixel_primary@"$IP":"./Music/Mp3 Player/"
        '')
    ];
}
