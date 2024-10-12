{ config, lib, ... }:

with lib;

{
    imports = [
        ./steam.nix
        ./lutris.nix
        ./limo.nix
        ./loot.nix
    ];

    options.ethorbit.workstation.home-manager.flatpak = {
        overrides.games.filesystems = mkOption {
            type = types.listOf types.str;
            default = [
                "/mnt/games:rw"
                "/mnt/storage/Documents/My Games"
                "/mnt/storage/Pictures/Steam:rw"
                # Garry's Mod stuff
                "/mnt/glua:ro"
                "/mnt/storage/Projects/Cheats/gmod/autorun:ro"
                "/mnt/storage/Projects/Cheats/gmod/autorun/logs:rw"
                "/mnt/storage/Projects/Cheats/gmod/autorun/lua_dumps:rw"
            ];
        };
    };
}
