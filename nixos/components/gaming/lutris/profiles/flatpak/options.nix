{ config, pkgs, lib, ... }:

with pkgs;
with lib;

let
    cfg = config.ethorbit.components.gaming.lutris.flatpak;
in
{
    options.ethorbit.components.gaming.lutris.flatpak = {
        # Shouldn't be changed, only referenced.
        appName = mkOption {
            type = types.str;
            default = "net.lutris.Lutris";
        };

        gamescope = {
            enable = mkOption {
                type = types.bool;
                description = ''
                    Whether or not to launch Lutris inside native Gamescope.
                    
                    This is useful if you are running into Flatpak Gamescope issues or
                    don't want to edit in gamescope launch params for every single game.
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
                    default = (writeShellScript "gamescope-lutris.sh" ''
                        ${cfg.gamescope.commands.gamemode} \
                            flatpak run --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" ${cfg.appName}
                    '');
                };
            };

            desktop = {
                defaultProps = mkOption {
                    type = types.attrs;
                    default = {
                        icon = "net.lutris.Lutris";
                        terminal = false;
                        type = "Application";
                        categories = [
                            "Game"
                        ];
                        mimeType = [
                            "x-scheme-handler/lutris"
                        ];
                        settings = {
                            X-Desktop-File-Install-Version = "0.28";
                            StartupWMClass = "Lutris";
                            X-Flatpak-RenamedFrom = "lutris.desktop";
                            X-Flatpak = "com.valvesoftware.Steam";
                        };
                    };
                };
            };
        };
    };
}
