{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.scream.scream = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "scream-scream.sh" ''
                scream="${pkgs.scream}/bin/scream"
                pgrep="${pkgs.procps}/bin/pgrep"

                [ ! $(command -v scream) ] && echo "" && exit

                if [[ ! -z $(pgrep -x scream) ]]; then 
                    echo -e "Scream \ue0e0";
                else
                    echo -e "Scream \ue202";
                fi  
            '');
        };
    };
}
