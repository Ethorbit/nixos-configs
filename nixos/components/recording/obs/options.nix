{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.recording.obs = {
        service.enable = mkOption {
            type = types.bool;
            default = false;
            description = "Set this to true if you want the custom OBS to run at startup.";
        };

        script = mkOption {
            type = types.package;
            default = null;
            description = "The script that things such as the Desktop Entry should execute.";
        };

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
                # It does this if you kill the process instead of exiting by GUI,
                # but that's how Linux shutdown works..
                "--disable-shutdown-check"
            ];
        };
    };
}
