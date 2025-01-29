{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let
    cfg = config.ethorbit.components.gaming.moonlight.flatpak;
in
{
    options.ethorbit.components.gaming.moonlight.flatpak = {
        # Shouldn't be changed, only referenced.
        appName = mkOption {
            type = types.str;
            default = "com.moonlight_stream.Moonlight";
        };

        # See first before running Moonlight in Gamescope
        # https://github.com/LizardByte/Sunshine/issues/1429
        # (It has the potential to cause stuttering and freezing)
        gamescope = {
            enable = mkOption {
                type = types.bool;
                description = ''
                    Whether or not to launch Moonlight inside native Gamescope.
                   
                    This is useful if you're running into multi-monitor issues
                    during the stream
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
                            flatpak run --env=DISPLAY="$GAMESCOPE_DISPLAY" ${cfg.appName}
                    '');
                };
            };

            desktop = {
                defaultProps = mkOption {
                    type = types.attrs;
                    default = {
                        icon = "com.moonlight_stream.Moonlight";
                        terminal = false;
                        type = "Application";
                        categories = [
                            "Qt"
                            "Game"
                        ];
                        settings = {
                            X-Flatpak = "com.moonlight_stream.Moonlight";
                        };
                    };
                };
            };
        };
    };
}
