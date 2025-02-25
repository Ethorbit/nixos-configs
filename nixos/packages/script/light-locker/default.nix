{ config, pkgs, lib, ... }:

with lib;

{
    options.ethorbit.pkgs.script.light-locker = {
        script = mkOption {
            type = types.package;
            default = (pkgs.writeShellScriptBin "script" ''
                ${pkgs.lightlocker}/bin/light-locker ${escapeShellArgs config.ethorbit.pkgs.script.light-locker.extraFlags}
            '');
        };

        extraFlags = mkOption {
            type = types.listOf types.str;
            default = [
                "--lock-on-lid"
                "--lock-after-screensaver=5"
                "--lock-on-suspend"
            ];
        };
    };
}
