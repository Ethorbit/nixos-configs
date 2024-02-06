{ config, lib, pkgs, ... }:

{
    options = with lib; {
        ethorbit.polybar.scripts.amd.gpu-usage = lib.mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "amd-gpu-usage.sh" ''
                radeontop="${pkgs.radeontop}/bin/radeontop"
                [ ! $(command -v "$radeontop") ] && echo "" && exit
                echo $("$radeontop" -l 1 -d - -i 1 | grep --line-buffered -oP "gpu \K\d{1,3}")%
            '');
        };
    };
}
