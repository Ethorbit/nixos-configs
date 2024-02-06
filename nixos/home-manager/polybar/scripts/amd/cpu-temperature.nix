{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.amd.cpu-temperature = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "amd-cpu-temperature.sh" ''
                sensors="${pkgs.lm_sensors.outPath}/bin/sensors"
                awk="${pkgs.gawk}/bin/awk"
                jq="${pkgs.jq.outPath}/bin/jq"

                [ ! $(command -v "$sensors") ] && echo "" && exit
                TEMP=$("$sensors" -j k10temp-pci-00c3 2> /dev/null)
                TEMP=$(echo $TEMP | "$jq" '."k10temp-pci-00c3".Tdie.temp2_input')
                TEMP=$(echo $TEMP | "$awk" '{print int($1+0.5)}')
                echo "$TEMP °C "
            '');
        };
    };
}

