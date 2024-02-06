{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.launch = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "launch.sh" ''
                ITER=0
                for monitor in $("${pkgs.polybar}/bin/polybar" --list-monitors | "${pkgs.coreutils}/bin/cut" -d":" -f1); do
                    if [ $ITER -ne 0 ]; then  # Primary (which shows first) uses main, so we skip it.'      
                        BAR="notmain"
                    else
                        BAR="main"  
                    fi

                    MONITOR=$monitor "${pkgs.polybar}/bin/polybar" --reload $BAR &
                    echo "Ran $BAR on $monitor";

                    ((ITER++))
                done

                echo "Bars launched..."
            '');
        };
    };
}
