{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.recording.obs = {
        command = {
            gamescope = mkOption {
                type = types.str;
                default = strings.concatStringsSep " " (
                    [
                        "obs"
                    ]
                    ++ config.ethorbit.components.recording.obs.flags
                );
            };
        };

        flags = mkOption {
            type = types.listOf types.str;
            description = ''The flags to pass to OBS. Do obs --help'';
            default = [
                # Ideal setup if you just want to save last X secs when something cool happens
                "--startreplaybuffer"
                "--minimize-to-tray"
            ];
        };
    };
}
