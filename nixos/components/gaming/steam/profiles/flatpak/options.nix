{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    cfg = config.ethorbit.components.gaming.steam.flatpak;
in
{
    options.ethorbit.components.gaming.steam.flatpak = {
        appName = mkOption {
            type = types.str;
            default = "com.valvesoftware.Steam";
        };

        offline = {
            enable = mkOption {
                type = types.bool;
                description = ''
                    Adds shortcuts for launching the Steam flatpak without internet connectivity.

                    It's only useful if internet connectivity is causing problems for Singleplayer games.
                '';
                default = false;
            };
        };

        gamescope = {
            enable = mkOption {
                type = types.bool;
                description = ''
                    Whether or not to launch Steam inside native Gamescope.
                    
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
                flatpak = mkOption {
                    type = types.package;
                    default = (writeShellScript "wrapper" ''steam'');
                };

                normal = mkOption {
                    type = types.package;
                    default = (writeShellScript "gamescope-steam.sh" ''
                        ${cfg.gamescope.commands.gamemode} \
                            flatpak run --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" \
                                --command=${cfg.gamescope.scripts.flatpak.outPath} ${cfg.appName}
                    '');
                };

                offline = mkOption {
                    type = types.package;
                    default = (writeShellScript "gamescope-steam-offline.sh" ''
                        ${cfg.gamescope.commands.gamemode} \
                            flatpak run --unshare=network --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" \
                                --command=${cfg.gamescope.scripts.flatpak.outPath} ${cfg.appName}
                    '');
                };
            };

            desktop = {
                defaultProps = mkOption {
                    type = types.attrs;
                    default = {
                        icon = "com.valvesoftware.Steam";
                        terminal = false;
                        type = "Application";
                        categories = [
                            "FileTransfer"
                            "Game"
                        ];
                        mimeType = [
                            "x-scheme-handler/steam"
                            "x-scheme-handler/steamlink"
                        ];
                        settings = {
                            X-Desktop-File-Install-Version = "0.27";
                            StartupWMClass = "Steam";
                            X-Flatpak-RenamedFrom = "steam-offline.desktop";
                            X-Flatpak-Tags = "proprietary";
                            X-Flatpak = "com.valvesoftware.Steam";
                        };
                    };
                };
            };
        };
    };
}
