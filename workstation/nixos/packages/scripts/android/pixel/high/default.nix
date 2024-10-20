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
    ];
}
