{ config, lib, pkgs, ... }:

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
                ExecStart = ''${pkgs.feh}/bin/feh --randomize --bg-fill "%h/.wallpapers"'';
            };

            wantedBy = [ "default.target" ];
        };
    };
}
