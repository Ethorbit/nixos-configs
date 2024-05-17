{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        (pkgs.writeShellScriptBin "backup-android-pixel-u12.sh" ''
            IP="$1" && [ -z "$IP" ] && echo "Please specify the IP." && exit 0
            ${config.ethorbit.pkgs.mount-sshfs-run-service}/bin/mount-sshfs-run-service.sh \
                --host u12_a215 \
                --ip "$IP" \
                --remote-dir ./ \
                --mount-dir "$HOME/mnt/android_pixel_u12" \
                --service-name restic-backups-android-pixel-u12.service \
                --system-service
        '')
    ];
}
