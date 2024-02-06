{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.amd.cpu = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "amd-cpu.sh" ''
                TEMP=$("${config.ethorbit.polybar.scripts.amd.cpu-temperature}")
                USAGE=$("${config.ethorbit.polybar.scripts.amd.cpu-usage}")

                echo "$TEMP$USAGE"
            '');
        };
    };
}
