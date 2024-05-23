{ config, lib, pkgs, ... }:

{
    imports = [
        
    ];

    options.ethorbit.services.selkies-gstreamer = with lib; {
        enable = mkOption {
            type = types.bool;
            default = true;
        };

        user = mkOption {
            type = types.str;
            description = "The user that selkies-gstreamer will run under.";
            default = config.ethorbit.users.primary.username;
            example = "myuser";
        };
    };

    config = {
        systemd.services."selkies-gstreamer" = {
            enable = config.ethorbit.services.selkies-gstreamer.enable;
            description = "Systemd port of nvidia-egl-docker's 'selkies-gstreamer' supervisor service";
            after = [ "network.target" ];

            serviceConfig = {
                User = config.ethorbit.services.selkies-gstreamer.user;
                Type = "simple";
                Restart = "on-failure";
                RestartSec = 5;
            };

            script = ''
                           
            '';

            wantedBy = [ "default.target" ];
        };
    };
}
