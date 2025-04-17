# 11pm, night light mode
# 7am, normal blue light
# Transitions immediately
# Mimics my setup on Android with its "Night Light"

{ config, lib, pkgs, ... }:

{
    systemd.user = {
        services = {
            "redshift-daytime" = {
                script = lib.mkDefault ''
                ${pkgs.redshift}/bin/redshift -x
                '';
            };

            "redshift-nighttime" = {
                script = lib.mkDefault ''
                ${pkgs.redshift}/bin/redshift -x
                ${pkgs.redshift}/bin/redshift -O 2000
                '';
            };
        };

        timers = {
            "redshift-daytime" = {
                enable = true;
                timerConfig = {
                    OnCalendar = lib.mkDefault "07:00";
                    Persistent = true;
                };
                wantedBy = [ "timers.target" ];
            };

            "redshift-nighttime" = {
                enable = true;
                timerConfig = {
                    OnCalendar = lib.mkDefault "00:00";
                    Persistent = true;
                };
                wantedBy = [ "timers.target" ];
            };
        };
    };
}
