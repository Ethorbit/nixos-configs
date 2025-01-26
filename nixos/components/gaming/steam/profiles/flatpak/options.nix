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
                    "-w 1920"
                    "-h 1080"
                    "-W 1920"
                    "-H 1080"
                    "-b"
                    "--force-windows-fullscreen"
                    "--force-grab-cursor"
                    "-o 20"
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
                    default = strings.concatStringsSep " " (
                        [
                            "${gamescope}/bin/gamescope"
                        ]
                        ++ config.ethorbit.components.gaming.steam.flatpak.gamescope.flags
                    );
                };

                gamemode = mkOption {
                    type = types.str;
                    default = "${gamemode}/bin/gamemoderun";
                };
            };

            wrappers = {
                flatpak = mkOption {
                    type = types.package;
                    default = writeShellScriptBin "wrapper" ''steam'';
                };

                # Since we need to start Steam without gamescope (so we can attach to it later)
                # we need to make sure to run gamescope in the background and kill it when our wrapper does (e.g when Steam closes)
                #
                # We did it this way so that the Steam overlay can work, as starting Steam with gamescope directly causes the Overlay to never work
                # https://github.com/ValveSoftware/gamescope/issues/835
                prefix = mkOption {
                    type = types.package;
                    default = writeShellScriptBin "script" ''
                        LOG_PATH="$XDG_RUNTIME_DIR/.flatpak-steam-gamescope.txt"

                        GAMESCOPE_PID=$(
                            ${config.ethorbit.components.gaming.steam.flatpak.gamescope.commands.gamescope} > "$LOG_PATH" 2> "$LOG_PATH" &
                            echo $(($BASHPID+1))
                        )

                        # Wait a little for the startup log to arrive
                        sleep 1

                        # Extract which display number this gamescope process is using so that we can run Steam on it later
                        GAMESCOPE_DISPLAY=$(cat "$LOG_PATH" | grep 'Starting Xwayland on :[0-9]' | grep -o ':[0-9]$')
                        export DISPLAY="$GAMESCOPE_DISPLAY"

                        # Kill our Gamescope process if our wrapper script exits (e.g if Steam closes)
                        function cleanup()
                        {
                            kill -KILL "$GAMESCOPE_PID"
                        }

                        trap cleanup EXIT
                    '';
                };

                normal = mkOption {
                    type = types.package;
                    default = writeShellScriptBin "gamescope-steam.sh" ''
                        source "${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.prefix}/bin/script"
                        ${config.ethorbit.components.gaming.steam.flatpak.gamescope.commands.gamemode} \
                            flatpak run --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" \
                                --command=${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.flatpak}/bin/wrapper ${config.ethorbit.components.gaming.steam.flatpak.appName}
                    '';
                };

                offline = mkOption {
                    type = types.package;
                    default = writeShellScriptBin "gamescope-steam-offline.sh" ''
                        source "${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.prefix}/bin/script"
                        ${config.ethorbit.components.gaming.steam.flatpak.gamescope.commands.gamemode} \
                            flatpak run --unshare=network --branch=stable --arch=x86_64 --env=DISPLAY="$GAMESCOPE_DISPLAY" \
                                --command=${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.flatpak}/bin/wrapper ${config.ethorbit.components.gaming.steam.flatpak.appName}
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
