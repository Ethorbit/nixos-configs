{ config, pkgs, ... }:

{
    services.spice-vdagentd.enable = true;

    # The spice-vdagent process never runs automatically
    # so we'll create our own service that will do just that
    systemd.user.services."spice-vdagent" = {
        enable = true;
        
        serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.spice-vdagent}/bin/spice-vdagent -x'';
            Restart = "always";
            RestartSec = 5;
        };

        wants = [ "spice-vdagentd.service" ];
        after = [ "graphical-session.target" ];
        partOf = [ "graphical-session.target" ];
        wantedBy = [ "spice-display-resizer.service" ];
    };

    # We need a way to resize the spice display dynamically
    # since it won't do it by itself..
    systemd.user.services."spice-display-resizer" = {
        enable = true;
        
        serviceConfig = {
            Type = "simple";
            ExecStart = ''${pkgs.xorg.xrandr}/bin/xrandr --output Virtual-1 --auto'';
            StartLimitInterval = 1;
            StartLimitBurst = 2;
            Restart = "always";
            RestartSec = 1;
        };
        
        requires = [ "spice-vdagent.service" ];
        wantedBy = [ "spice-vdagent.service" ];
    };
}
