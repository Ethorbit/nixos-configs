# Mount LUKS devices which were unlocked by a keyfile
{ config, lib, pkgs, ... }:

with lib;
with pkgs;

{
    options.ethorbit.steamdeck.packages.decrypt.mount-key = mkOption {
        type = types.package;
        default = (pkgs.writeShellScript "script" ''
            ${mount}/bin/mount -o subvol=home,compress-force=zstd:12,noatime,discard /dev/mapper/crypt_sdcard /home

            ${coreutils-full}/bin/mkdir -p /mnt/{sdcard_games,sdcard_storage,sdcard_high}
            ${mount}/bin/mount -o subvol=games,compress-force=zstd:12,noatime,discard /dev/mapper/crypt_sdcard /mnt/sdcard_games
            ${mount}/bin/mount -o subvol=storage,compress-force=zstd:12,noatime,discard /dev/mapper/crypt_sdcard /mnt/sdcard_storage
            ${mount}/bin/mount -o subvol=high,compress-force=zstd:12,noatime,discard /dev/mapper/crypt_sdcard /mnt/sdcard_high

            ${coreutils-full}/bin/mkdir /swap
            ${mount}/bin/mount -o subvol=swap /dev/mapper/crypt_sdcard /swap
            ${util-linux}/bin/swapon /swap/swapfile

            # Speed limits to help prevent cache filling
            ${coreutils-full}/bin/mkdir -p /sys/fs/cgroup/blkio
            ${mount}/bin/mount /sys/fs/cgroup/blkio
            echo "179:0 150" | tee -a /sys/fs/cgroup/blkio/blkio.throttle.write_iops_device
            echo "179:0 20000000" | tee -a /sys/fs/cgroup/blkio/blkio.throttle.write_bps_device
        '');
    };
}
