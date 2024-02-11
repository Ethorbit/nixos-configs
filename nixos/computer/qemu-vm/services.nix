{ config, pkgs, ... }:

{
    services.xserver.videoDrivers = [ "qxl" ];

    systemd.user.timers."xrandr-auto-resizer" = {
        enable = true;
        description = "Sets QXL resolution with xrandr every 3 seconds.";
        
        timerConfig = {
            OnUnitActiveSec = 3;
            OnBootSec = 0;
            AccuracySec = "1us";
        };
        
        wantedBy = [ "timers.target" ];
    };

    systemd.user.services."xrandr-auto-resizer" = {
        enable = true;
        
        serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --auto'';
        };
        
        wantedBy = [ "default.target" ];
    };
}
