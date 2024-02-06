{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.nvidia.gpu-usage = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "nvidia-gpu-usage.sh" ''
                [ ! $(command -v nvidia-smi) ] && echo "" && exit
                echo $(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader,nounits)%
            '');
        };
    };
}

