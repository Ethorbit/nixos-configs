{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    cfg = config.ethorbit.components.gaming.roblox.flatpak;
in
{
    options.ethorbit.components.gaming.roblox.flatpak = {
        game = {
            appName = mkOption {
                type = types.str;
                default = "org.vinegarhq.Sober";
            };

            gamescope = {
                scripts = {
                    normal = mkOption {
                        type = types.package;
                        default = (writeShellScript "script" ''
                            flatpak run --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" ${cfg.game.appName}
                        '');
                    };
                };
            };
        };

        studio = {
            appName = mkOption {
                type = types.str;
                default = "org.vinegarhq.Vinegar";
            };

            gamescope = {
                scripts = {
                    normal = mkOption {
                        type = types.package;
                        default = (writeShellScript "script" ''
                            ${cfg.gamescope.commands.gamemode} \
                                flatpak run --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" ${cfg.studio.appName}
                        '');
                    };
                };
            };
        };

        # Current version of Sober doesn't even support Wayland, so this won't work
        # https://github.com/vinegarhq/sober/issues/547
        gamescope = {
            enable = mkOption {
                type = types.bool;
                description = "Whether or not to launch Roblox programs inside native Gamescope.";
                default = false;
            };

            commands = {
                gamemode = mkOption {
                    type = types.str;
                    default = "${gamemode}/bin/gamemoderun";
                };
            };
        };
    };
}
