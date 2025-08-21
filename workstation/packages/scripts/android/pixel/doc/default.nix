{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (pkgs.writeShellScriptBin "backup-android-pixel-doc.sh" ''
            IP="$1" && [ -z "$IP" ] && echo "Please specify the IP." && exit 0
            ${pkgs.ethorbit.mount-sshfs-run-service}/bin/mount-sshfs-run-service.sh \
                --host android_pixel_doc \
                --ip "$IP" \
                --remote-dir ./ \
                --mount-dir "$HOME/mnt/android_pixel_doc" \
                --service-name restic-backups-android-pixel-doc.service \
                --system-service
        '')
    ];
}
