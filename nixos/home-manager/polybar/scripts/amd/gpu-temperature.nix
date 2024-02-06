{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.amd.gpu-temperature = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "amd-gpu-temperature.sh" ''
                sensors="${pkgs.lm_sensors.outPath}/bin/sensors"
                jq="${pkgs.jq.outPath}/bin/jq"
                
                [ ! $(command -v "$sensors") ] && echo "" && exit
                TEMP=$("$sensors" -j amdgpu-pci-2500 2> /dev/null)
                TEMP=$(echo $TEMP | "$jq" '."amdgpu-pci-2500".edge.temp1_input')
                echo "$TEMP ℃"
            '');
        };
    };
}

