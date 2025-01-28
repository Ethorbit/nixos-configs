{ config, pkgs, lib, ... }:

with lib;

let
    cfg = config.ethorbit.components.gaming.minecraft.launcher.flatpak;
in
{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${cfg.appName}";
                    origin = "flathub";
                }
            ];

            overrides = {
                "${cfg.appName}" = {
                    # Give it access to the Flatpak Gamescope portal
                    Context = mkIf cfg.gamescope.enable {
                        filesystems = [ "xdg-run/gamescope-0:ro" ];
                        env = [
                            "LD_LIBRARY_PATH=/usr/lib/extensions/vulkan/gamescope/lib"
                            "PATH=/usr/lib/extensions/vulkan/gamescope/bin"
                        ];
                    };

                    # Make it use gamemoderun
                    Application.command = "gamemoderun prismlauncher";
                };
            };
        };

        xdg.desktopEntries."prism-launcher-gamescope" = mkIf cfg.gamescope.enable (mkMerge [
            cfg.gamescope.desktop.defaultProps
            {
                name = "Prism Launcher (Gamescope)";
                comment = "Discover, manage, and play Minecraft instances inside Gamescope";
                exec = config.ethorbit.components.gaming.dependencies.gamescope.wrappers."minecraft-launcher".wrapper.outPath;
            }
        ]);
    } ];
}
