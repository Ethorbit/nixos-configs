{ config, pkgs, lib, ... }:

with lib;

let
    cfg = config.ethorbit.components.gaming.roblox.flatpak;
in
{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${cfg.game.appName}";
                    origin = "flathub";
                }
                {
                    appId = "${cfg.studio.appName}";
                    origin = "flathub";
                }
            ];

            overrides = {
                "${cfg.game.appName}" = {
                    # Give it access to the Flatpak Gamescope portal
                    Context = mkIf cfg.gamescope.enable {
                        filesystems = [ "xdg-run/gamescope-0:ro" ];
                        env = [
                            "LD_LIBRARY_PATH=/usr/lib/extensions/vulkan/gamescope/lib"
                            "PATH=/usr/lib/extensions/vulkan/gamescope/bin"
                        ];
                    };
                };

                "${cfg.studio.appName}" = {
                    # Give it access to the Flatpak Gamescope portal
                    Context = mkIf cfg.gamescope.enable {
                        filesystems = [ "xdg-run/gamescope-0:ro" ];
                        env = [
                            "LD_LIBRARY_PATH=/usr/lib/extensions/vulkan/gamescope/lib"
                            "PATH=/usr/lib/extensions/vulkan/gamescope/bin"
                        ];
                    };
                };
            };
        };

        xdg.desktopEntries = {
            "roblox-game-gamescope" = mkIf cfg.gamescope.enable (mkMerge [
                {
                    name = "Sober (Gamescope)";
                    genericName = "Roblox Player (Gamescope)";
                    icon = "org.vinegarhq.Sober";
                    comment = "Play, chat & explore on Roblox";
                    exec = config.ethorbit.components.gaming.dependencies.gamescope.wrappers."roblox-game".wrapper.outPath;
                    categories = [
                        "GNOME"
                        "GTK"
                        "Game"
                    ];
                    terminal = false;
                    type = "Application";
                }
            ]);

            "roblox-studio-gamescope" = mkIf cfg.gamescope.enable (mkMerge [
                {
                    name = "Vinegar (Gamescope)";
                    genericName = "Roblox Studio (Gamescope)";
                    icon = "org.vinegarhq.Vinegar";
                    comment = "Run Roblox Studio on Linux";
                    exec = config.ethorbit.components.gaming.dependencies.gamescope.wrappers."roblox-studio".wrapper.outPath;
                    categories = [
                        "GNOME"
                        "GTK"
                        "Game"
                        "PackageManager"
                    ];
                    terminal = false;
                    type = "Application";
                }
            ]);
        };
    } ];
}
