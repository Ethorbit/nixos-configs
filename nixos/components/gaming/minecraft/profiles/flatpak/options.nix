{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let
    cfg = config.ethorbit.components.gaming.minecraft.launcher.flatpak;
in
{
    options.ethorbit.components.gaming.minecraft.launcher.flatpak = {
        appName = mkOption {
            type = types.str;
            default = "org.prismlauncher.PrismLauncher";
        };

        gamescope = {
            enable = mkOption {
                type = types.bool;
                description = ''
                    Whether or not to launch Minecraft and its launchers inside native Gamescope.
                '';
                default = false;
            };

            commands = {
                gamemode = mkOption {
                    type = types.str;
                    default = "${gamemode}/bin/gamemoderun";
                };
            };
            
            scripts = {
                normal = mkOption {
                    type = types.package;
                    default = (writeShellScript "script" ''
                        ${cfg.gamescope.commands.gamemode} \
                            flatpak run --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" ${cfg.appName}
                    '');
                };
            };

            desktop = {
                defaultProps = mkOption {
                    type = types.attrs;
                    default = {
                        icon = "org.prismlauncher.PrismLauncher";
                        terminal = false;
                        type = "Application";
                        categories = [
                            "Game"
                            "ActionGame"
                            "AdventureGame"
                            "Simulation"
                        ];
                        mimeType = [
                            "application/zip"
                            "application/x-modrinth-modpack+zip"
                            "x-scheme-handler/curseforge"
                            "x-scheme-handler/prismlauncher"
                        ];
                        settings = {
                            StartupWMClass = "PrismLauncher";
                            X-Flatpak = "org.prismlauncher.PrismLauncher";
                        };
                    };
                };
            };
        };
    };
}
