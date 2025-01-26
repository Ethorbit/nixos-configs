{ config, lib, pkgs, ... }:

with lib;

let
    cfg = config.ethorbit.services.xidlehook;
in
{
    options.ethorbit.services.xidlehook = {
        enable = mkOption {
            type = types.bool;
            default = false;
        };

        display = mkOption {
            type = types.str;
            description = ''
                The Display # you want to auto lock.
                If you want to do several, you'll need to create an extra service for each #
            '';
            default = ":0";
        };

        timers = mkOption {
            description = ''A list of timers. Each timer will execute a command after a specified period of inactivity.'';
            type = types.listOf (types.attrsOf (types.submodule {
                options = {
                    time = mkOption {
                        type = types.int;
                        description = ''Time (in seconds) before lock command is executed.'';
                        default = 900;
                    };

                    command = mkOption {
                        type = types.str;
                        description = ''The command xidlehook should execute upon locking.'';
                        default = "${pkgs.i3lock}/bin/i3lock";
                    };

                    canceller = mkOption {
                        type = types.str;
                        default = "";
                        description = ''
                            The canceller is what is invoked when the user becomes active after the timer has gone off, but before the
                            next timer (if any). Pass an empty string to not have one.
                        '';
                    };
                };
            }));
            default = [
                {
                    config = {

                    };
                }
            ];
        };

        extraOptions = mkOption {
            type = types.listOf types.str;
            description = ''Extra stuff to pass to xidlehook.'';
            default = [
                "--detect-sleep"
            ];
        };
    };

    config.systemd.user.services."xidlehook" = mkIf cfg.enable {
        enable = true;
        description = "Automatic Screen Locker";

        environment = {
            DISPLAY = cfg.display;
            XIDLEHOOK_SOCK = "%t/xidlehook.socket";
        };

        serviceConfig = {
            Type = "simple";
            ExecStart = strings.concatStringsSep " " (
                [
                    "${pkgs.xidlehook}/bin/xidlehook"
                    "--socket $XIDLEHOOK_SOCK"
                ]
                ++ cfg.extraOptions
                ++ (map (timer: "--timer ${toString timer.config.time} '${timer.config.command}' '${timer.config.canceller}'") cfg.timers)
            );
            Restart = "always";
        };

        wantedBy = [ "multi-user.target" ];
    };
}
