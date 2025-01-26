# Made because xautolock doesn't even work, despite pre-existing nix implementation :P
# Use this instead to save your sanity :D

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

        script = mkOption {
            type = types.package;
            description = ''The script xidlehook should execute upon locking.'';
            default = pkgs.writeShellScript "script" ''
                exec ${cfg.command}
            '';
        };

        canceller = mkOption {
            type = types.str;
            default = "";
            description = ''
                The canceller is what is invoked when the user becomes active after the timer has gone off, but before the
                next timer (if any). Pass an empty string to not have one.
            '';
        };

        extraOptions = mkOption {
            type = types.listOf types.str;
            description = ''Extra stuff to pass to xidlehook.'';
            default = [
                "--detect-sleep"
            ];
        };
    };

    config.systemd.user.services."xidlehook" = {
        enable = cfg.enable;
        description = "Automatic Screen Locker";
        restartTriggers = [ cfg.script ];

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
                ++ [
                    "--timer ${toString cfg.time} '${cfg.script}' '${cfg.canceller}'"
                ]
            );
            Restart = "always";
        };

        wantedBy = [ "multi-user.target" ];
    };
}
