{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.recording.obs = {
        command = mkOption {
            type = types.str;
            default = (strings.concatStringsSep " " (
                [
                    "obs"
                ]
                ++ config.ethorbit.components.recording.obs.flags
            ));
        };

        extraCommands = mkOption {
            type = types.lines;
            default = '''';
            description = ''Additional commands called after obs'';
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
