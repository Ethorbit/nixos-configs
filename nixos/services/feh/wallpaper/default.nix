{ config, lib, pkgs, ... }:

let
    # Solution for feh randomizing image (but staying the same across monitors)
    # from here: https://www.reddit.com/r/linuxquestions/comments/xwi1dj/use_feh_to_display_the_same_random_image_on_all/?rdt=62612
    script = pkgs.writeShellScriptBin "script" ''
    ${pkgs.coreutils}/bin/shuf -e -n1 "$HOME/.wallpapers/"* |\
        ${pkgs.toybox}/bin/xargs \
            ${pkgs.feh}/bin/feh --bg-fill
    '';
in
{
    options.ethorbit.services.feh = with lib; {
        enable = mkOption {
            type = types.bool;
            default = true;
        };
    };

    config = {
        systemd.user.timers."feh-desktop-wallpaper" = {
            enable = config.ethorbit.services.feh.enable;
            description = "Sets desktop wallpaper with feh every 5 minutes";

            timerConfig = {
                OnBootSec = 0;
                OnUnitActiveSec = "5m";
            };

            wantedBy = [ "timers.target" ];
        };

        systemd.user.services."feh-desktop-wallpaper" = {
            enable = config.ethorbit.services.feh.enable;
            description = "Sets desktop wallpaper with feh";

            serviceConfig = {
                Type = "simple";
                ExecStart = ''${script}/bin/script'';
            };

            wantedBy = [ "default.target" ];
        };
    };
}
