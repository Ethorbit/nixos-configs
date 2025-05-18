{ config, pkgs, ... }:

let
    cfg = config.ethorbit.components.recording.obs;
in
{
    systemd.user.services."obs" = {
        enable = cfg.service.enable;
        description = "Custom OBS at startup";
        partOf = [ "graphical-session.target" ];
        after = [ "graphical-session.target" ];
        serviceConfig = {
            Type = "exec";
            Restart = "no";
            ExecStart = "${pkgs.bash}/bin/bash ${cfg.script.outPath}";
        };
        wantedBy = [ "graphical-session.target" ];
    };
}
