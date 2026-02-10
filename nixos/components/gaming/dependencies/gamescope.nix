{ config, lib, pkgs, ... }:

with lib;
with pkgs;

{
    options.ethorbit.components.gaming.dependencies.gamescope = {
        wrappers = mkOption {
            description = ''
                This is used for making gamescope wrappers
                These are useful for attaching processes to existing gamescope sessions.

                Create a wrapper, define a script or source the {script} inside YOUR script
                Anything your script does after the source runs in gamescope DISPLAY.
                It can also access GAMESCOPE_PID and GAMESCOPE_DISPLAY.

                Once your script exits, the wrapper automatically kills the gamescope process.
            '';

            default = { };

            type = types.attrsOf (types.submodule ({ name, config, ... }: {
                options = {
                    package = mkOption {
                        type = types.package;
                        default = pkgs.gamescope;
                        description = "The Gamescope package to use.";
                    };
                
                    flags = mkOption {
                        type = types.listOf types.str;
                        description = ''The flags to pass to gamescope. Do gamescope --help'';
                        default = [
                            # 1080p gaming, very common
                            "-w 1920"
                            "-h 1080"
                            "-W 1920"
                            "-H 1080"
                            # Some games glitch with fullscreen, so borderless fullscreen instead
                            "-b"
                            "--force-windows-fullscreen"
                            "--force-grab-cursor"
                            # Prevents the GPU from hogging when unfocused
                            "-o 20"
                            # Helps make things smoother
                            "--adaptive-sync"
                            "--immediate-flips"
                        ];
                    };

                    commands = {
                        gamescope = mkOption {
                            type = types.str;
                            default = strings.concatStringsSep " " (
                                [
                                    "${config.package}/bin/gamescope"
                                ]
                                ++ config.flags
                            );
                        };
                    };

                    script = mkOption {
                        type = types.package;
                        description = ''Your custom script that the Gamescope wrapper will execute after its session goes up and is available.'';
                        default = (writeShellScript "script" '''');
                    };

                    wrapper = mkOption {
                        type = types.package;

                        description = ''
                            The wrapper script. You can source this inside a separate script.
                            After sourcing, if it runs a GUI, that GUI will display inside the Gamescope window.
                        '';

                        # Since we need to start without gamescope (so we can attach to it later)
                        # we need to make sure to run gamescope in the background and kill it when our wrapper does (e.g when Steam closes)
                        #
                        # We did it this way as starting with gamescope directly causes various issues such as the Steam Overlay not
                        # working, Lutris mouse cursor not showing, etc
                        # https://github.com/ValveSoftware/gamescope/issues/835
                        default = (writeShellScript "gamescope-wrapper-${name}.sh" ''
                            LOG_PATH="$XDG_RUNTIME_DIR/${name}-gamescope.txt"
                            echo "$0 $(${toybox}/bin/date)" > "$LOG_PATH"

                            setsid ${config.commands.gamescope} >> "$LOG_PATH" 2>> "$LOG_PATH" < /dev/null &
                            GAMESCOPE_PID=$!

                            if [ -z "$GAMESCOPE_PID" ]; then
                                echo "Failed to start gamescope" >> "$LOG_PATH"
                                exit 1
                            fi

                            echo "Captured PID: $GAMESCOPE_PID" >> "$LOG_PATH"

                            # Wait a little for the startup logs to accumulate
                            sleep 1

                            # Extract which display number this gamescope process is using so that we can run Steam on it later
                            GAMESCOPE_DISPLAY=$(cat "$LOG_PATH" | grep 'Starting Xwayland on :[0-9]' | grep -o ':[0-9]$')
                            export DISPLAY="$GAMESCOPE_DISPLAY"

                            GAMESCOPE_DISPLAY_NUM=''${GAMESCOPE_DISPLAY#:}

                            # Kill our Gamescope process if our wrapper script exits (e.g if Steam closes)
                            function cleanup()
                            {
                                rm -f /tmp/.X''${GAMESCOPE_DISPLAY_NUM}-lock
                                rm -f /tmp/.X11-unix/X''${GAMESCOPE_DISPLAY_NUM}
                                rm -f $XDG_RUNTIME_DIR/gamescope-''${GAMESCOPE_DISPLAY_NUM}.lock

                                kill -TERM -"$GAMESCOPE_PID" 2>/dev/null
                                sleep 0.5
                                if kill -0 -"$GAMESCOPE_PID" 2>/dev/null; then
                                    kill -KILL -"$GAMESCOPE_PID" 2>/dev/null
                                fi
                            }

                            trap cleanup EXIT

                            echo "${config.script.outPath}" >> "$LOG_PATH"
                            [ -s "${config.script.outPath}" ] && "${config.script.outPath}"
                        '');
                    };
                };
            }));

            example = literalExpression ''
                gamescope.wrappers."steam" = {
                    flags = [
                        "-w 2560"
                        "-h 1440"
                        "-W 2560"
                        "-H 1440"
                        "-f"
                    ];
                };
            '';
        };
    };

    config = {
        programs.gamescope = {
            enable = true;
            # capSysNice = true; # This won't work because of stubborn linux kernel
        };

        #environment.systemPackages = with pkgs; [
        #    # Add each wrapper script to system packages
        #    (mapAttrsToList (name: value: value.wrapper.outPath) config.ethorbit.components.gaming.dependencies.gamescope.wrappers)
        #];
    };
}
