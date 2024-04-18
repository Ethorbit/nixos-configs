{ config, pkgs, lib, ... }:

{
    options.ethorbit.services.sunshine = with lib; {
        enable = mkOption {
            type = types.bool;
            default = true;
        };
    };

    config = {
        systemd.user.services."sunshine" = {
            enable = config.ethorbit.services.sunshine.enable;
            description = "Sunshine is a self-hosted game stream host for Moonlight.";
            startLimitIntervalSec = 500;
            startLimitBurst = 5;
            
            serviceConfig = {
                Type = "simple";
                #ExecStart = ''${pkgs.sunshine}/bin/sunshine'';
                # sunshine component adds a much needed wrapper
                ExecStart = ''${config.security.wrapperDir}/sunshine'';
                Restart = "on-failure";
                RestartSec = 5;
            };

            wantedBy = [ "graphical-session.target" ];
            after =  [ "graphical-session.target" ];
        };
    };
}
