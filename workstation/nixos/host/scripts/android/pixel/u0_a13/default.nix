{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (pkgs.writeShellScriptBin "backup-android-pixel-u0.sh" ''
            IP="$1" && [ -z "$IP" ] && echo "Please specify the IP." && exit 0
            ${config.ethorbit.pkgs.mount-sshfs-run-service}/bin/mount-sshfs-run-service.sh \
                --host u0_a130 \
                --ip "$IP" \
                --remote-dir ./ \
                --mount-dir "$HOME/mnt/android_pixel_u0" \
                --service-name restic-backups-android-pixel-u0.service \
                --system-service
        '')

        # sync-music
    ];
}
