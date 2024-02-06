{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.microphone = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "microphone.sh" ''
                if [[ $(~/.local/bin/pa-toggle-mic.sh --muted) -eq 0 ]]; then 
                    echo -e "Mic:  🔊";
                else
                    echo -e "Mic:  🔇";
                fi  
            '');
        };
    };
}

