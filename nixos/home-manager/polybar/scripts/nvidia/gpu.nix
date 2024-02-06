{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.nvidia.gpu = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "nvidia-gpu-usage.sh" ''
                [ ! $(command -v nvidia-smi) ] && echo "" && exit

                TEMP=$("${config.ethorbit.polybar.scripts.nvidia.gpu-temperature}")
                USAGE=$("${config.ethorbit.polybar.scripts.nvidia.gpu-usage}")

                echo "$USAGE $TEMP"
            '');
        };
    };
}
