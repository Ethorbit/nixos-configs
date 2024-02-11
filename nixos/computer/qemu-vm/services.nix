{ config, pkgs, ... }:

{
    services.xserver.videoDrivers = [ "qxl" ];

    systemd.user.services."xrandr-virtual-auto-resizer" = {
        enable = true;
        
        serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --auto'';
            StartLimitInterval = 0.5;
            StartLimitBurst = 2;
            Restart = "always";
            RestartSec = 0.5;
        };
        
        wantedBy = [ "default.target" ];
    };
}
