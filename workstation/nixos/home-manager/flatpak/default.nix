{ config, lib, ... }:

with lib;

{
    imports = [
        ./steam.nix
        ./lutris.nix
        ./limo.nix
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

    config = {
        home-manager.users.${config.ethorbit.users.primary.username} = {
            services.flatpak = {
                enable = true;
                packages = [
                    {
                        appId = "com.valvesoftware.Steam.CompatibilityTool.Proton-GE";
                        origin = "flathub";
                    }
                    {
                        appId = "runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08";
                        origin = "flathub";
                    }
                    {
                        appId = "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08";
                        origin = "flathub";
                    }
                ];
            };
        };
    };
}
