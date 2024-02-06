{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.amd.cpu-usage = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "amd-cpu-usage.sh" ''
                grep="${pkgs.gash-utils}/bin/grep"
                awk="${pkgs.gawk}/bin/awk"
                USAGE=echo " $("$grep" 'cpu ' /proc/stat | "$awk" '{cpu_usage=($2+$4)*100/($2+$4+$5)} | printf "%0.2f%", cpu_usage')
                echo $USAGE
            '');
        };
    };
}
