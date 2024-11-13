{ config, lib, pkgs, ... }:

{
    options = {
        ethorbit.pkgs.script.mount-wait = with pkgs; with lib; mkOption {
            type = types.package;
            description = "Haults execution until the specified mount is valid or the specified wait duration has been reached.";
            default = pkgs.writeShellScriptBin "mount-wait.sh" ''
            #!/bin/bash 
            MAX_WAIT="10"

            [[ -z "$1" ]] && exit 1 || MOUNT="$1" 

            if [[ ! -z "$2" ]]; then 
                reg="^[0-9]+$" && [[ ! "$2" =~ $reg ]] && exit 1  
                MAX_WAIT="$2"
            fi 

            seconds_waited=0 # not necessary, but prevents an env var from conflicting

            while [[ ! $(findmnt "$MOUNT") ]]; do 
                seconds_waited=$(($seconds_waited + 1))
                [[ "$seconds_waited" -ge "$MAX_WAIT" ]] && exit 1 || sleep 1
            done 

            echo 1 && exit 0
            '';
        };
    };
}
