{ config, lib, pkgs, ... }:

with lib;
with pkgs;

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

            flags = mkOption {
                type = types.listOf types.str;
                default = [
                    "-e"
                    "-w 1920"
                    "-h 1080"
                    "-W 1920"
                    "-H 1080"
                    "-b"
                    "--force-windows-fullscreen"
                    "--force-grab-cursor"
                    # helps prevent GPU hogging when focusing on other tasks
                    "-o 20"
                    # makes for a smoother experience
                    "--adaptive-sync"
                    "--immediate-flips"
                ];
            };

            mangohud = {
                enable = mkOption {
                    type = types.bool;
                    default = false;
                    description = ''
                        Whether or not to enable MangoHUD for the Steam client.

                        You can already add MANGOHUD=1 to the launch options of a game
                        to activate it, so launching Steam with it is not necessary.
                    '';
                };
            };

            commands = {
                gamescope = mkOption {
                    type = types.str;
                    default = "${gamescope}/bin/gamescope ${escapeShellArgs config.ethorbit.components.gaming.steam.flatpak.gamescope.flags}";
                };

                gamemode = mkOption {
                    type = types.str;
                    default = "${gamemode}/bin/gamemoderun --";
                };
            };

            wrappers = {
                flatpak = mkOption {
                    type = types.package;
                    default = writeShellScriptBin "wrapper" ''steam'';
                };

                normal = mkOption {
                    type = types.package;
                    default = writeShellScriptBin "gamescope-steam.sh" ''
                        ${config.ethorbit.components.gaming.steam.flatpak.gamescope.commands.gamescope} \
                            ${config.ethorbit.components.gaming.steam.flatpak.gamescope.commands.gamemode} \
                                flatpak run --branch=stable --arch=x86_64 --command=${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.flatpak}/bin/wrapper ${config.ethorbit.components.gaming.steam.flatpak.appName}
                    '';
                };

                offline = mkOption {
                    type = types.package;
                    default = writeShellScriptBin "gamescope-steam-offline.sh" ''
                        ${config.ethorbit.components.gaming.steam.flatpak.gamescope.commands.gamescope} \
                            ${config.ethorbit.components.gaming.steam.flatpak.gamescope.commands.gamemode} \
                                flatpak run --unshare=network --branch=stable --arch=x86_64 --command=${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.flatpak}/bin/wrapper ${config.ethorbit.components.gaming.steam.flatpak.appName}
                    '';
                };

                mangohud = mkOption {
                    default = writeShellScriptBin "gamescope-steam-mangohud.sh" ''
                    MANGOHUD=1 ${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.normal}/bin/gamescope-steam.sh
                    '';
                };

                mangohud-offline = mkOption {
                    default = writeShellScriptBin "gamescope-steam-mangohud-offline.sh" ''
                    MANGOHUD=1 ${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.offline}/bin/gamescope-steam-offline.sh
                    '';
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
