{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.steam.flatpak = {
        appName = mkOption {
            type = types.str;
            default = "com.valvesoftware.Steam";
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
                #"-r 60"
                default = [
                    "-e"
                    "-w 1920"
                    "-h 1080"
                    "-W 1920"
                    "-H 1080"
                    "-b"
                    "--force-grab-cursor"
                    # helps prevent GPU hogging when focusing on other tasks
                    "-o 20"
                    # makes for a smoother experience
                    "--adaptive-sync"
                    "--immediate-flips"
                ];
            };
        };
    };
}
