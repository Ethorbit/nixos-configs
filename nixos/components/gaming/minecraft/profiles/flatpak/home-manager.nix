{ config, pkgs, lib, ... }:

with lib;

let
    launcher = {
        app = "${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
        commandWrapper = pkgs.writeShellScriptBin "wrapper" ''
            /usr/lib/extensions/vulkan/gamescope/bin/gamescope ${escapeShellArgs config.ethorbit.components.gaming.minecraft.launcher.flatpak.gamescope.flags} gamemoderun -- prismlauncher
        '';
    };
in
{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${launcher.app}";
                    origin = "flathub";
                }
            ];

            overrides = {
                "${launcher.app}" = {
                    # Give it access to the Flatpak Gamescope portal
                    Context = {
                        filesystems = [ "xdg-run/gamescope-0:ro" "${launcher.commandWrapper}/bin/wrapper" ];
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

        xdg.desktopEntries."prism-launcher-gamescope" = {
            name = "Prism Launcher (Gamescope)";
            comment = "Prism Launcher, but contained inside Gamescope";
            exec = mkDefault ''flatpak run --command="${launcher.commandWrapper}/bin/wrapper" ${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}'';
            icon = "${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
            terminal = false;
            type = "Application";
            categories = [ "Game" ];
        };
    } ];
}
