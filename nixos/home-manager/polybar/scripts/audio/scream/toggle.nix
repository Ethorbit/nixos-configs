{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.scream.toggle = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "scream-toggle.sh" ''
                scream="${pkgs.scream}/bin/scream"
                pgrep="${pkgs.procps}/bin/pgrep"
                pkill="${pkgs.procps}/bin/pkill"
                
                [ ! $(command -v "$scream") ] && echo "" && exit

                if [[ ! -z $("$pgrep" -x scream) ]]; then
                    "$pkill" scream
                else
                    "$scream" -i virbr0 -o pulse
                fi
            '');
        };
    };
}
