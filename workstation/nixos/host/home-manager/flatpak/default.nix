{ config, lib, ... }:

with lib;

{
    imports = [
        ./steam.nix
        ./lutris.nix
    ];

    options.ethorbit.workstation.home-manager.flatpak = {
        overrides.games.filesystems = mkOption {
            type = types.listOf types.str;
            default = [
                "/mnt/games:rw"
                "/mnt/storage/StemaLibrary:rw"
                "/mnt/storage/Pictures/Steam:rw"
                "/mnt/glua:ro"
                "/mnt/storage/Projects/Cheats/gmod/autorun:ro"
                "/mnt/storage/Projects/Cheats/gmod/autorun/logs:rw"
                "/mnt/storage/Projects/Cheats/gmod/autorun/lua_dumps:rw"
            ];
        };
    };
}
