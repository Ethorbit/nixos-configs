{ config, lib, ... }:

{
    imports = [
        ./lutris.nix
        ./minecraft.nix
    ];

    options.ethorbit.workstation.home-manager.flatpak = with lib; {
        overrides.games.filesystems = mkOption {
            type = types.listOf types.str;
            default = [
                "/mnt/sdcard_games:rw"
                "/mnt/sdcard_storage/Documents/My Games:rw"
                "/mnt/sdcard_storage/Pictures/Steam:rw"
            ];
        };
    };
}
