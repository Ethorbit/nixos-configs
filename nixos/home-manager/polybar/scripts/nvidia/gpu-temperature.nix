{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.nvidia.gpu-temperature = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "nvidia-gpu-usage.sh" ''
                [ ! $(command -v nvidia-smi) ] && echo "" && exit
                echo "$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader,nounits)°C"
            '');
        };
    };
}
