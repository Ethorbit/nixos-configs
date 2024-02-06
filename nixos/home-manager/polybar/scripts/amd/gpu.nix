{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.amd.gpu = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "amd-gpu.sh" ''
                TEMP=$("${config.ethorbit.polybar.scripts.amd.gpu-temperature}")
                USAGE=$("${config.ethorbit.polybar.scripts.amd.gpu-usage}")

                echo "$USAGE $TEMP"
            '');
        };
    };
}

