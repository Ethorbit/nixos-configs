# NOTE: This is not really used anymore..
# Most environments support mouse control already
# There's no reason to configure it with custom nix

{ config, pkgs, lib, ... }:

with lib;
{
    options = {
        ethorbit.services.razer.mouse.xinputAccelSpeed = mkOption {
            type = types.str;
            default = "-0.7";
        };
    
        # Slow mouse a little, feels too fast under Linux. 
        # There's multiple Razer mice for some reason (Probably due to usb kvm switch)
        ethorbit.scripts.xinput.razer-mouse = mkOption {
            type = types.package;
            default = (pkgs.writeShellScript "xinput-razer-mouse.sh" ''
                xinput="${pkgs.xorg.xinput}/bin/xinput"
                grep="${pkgs.gash-utils}/bin/grep"
                cut="${pkgs.gash-utils}/bin/cut"
                for xinput_id in $("$xinput" list | "$grep" 'Razer Razer DeathAdder V2' | "$grep" -o 'id=[0-9]*' | "$cut" -c 4-); do
                    "$xinput" --set-prop "$xinput_id" "libinput Accel Speed" ${config.ethorbit.services.razer.mouse.xinputAccelSpeed}
                done
            '');
        };
    };

    config = mkIf config.services.xserver.enable {
        systemd.user.timers."xinput-razer-mouse" = {
            enable = true;
            description = "Sets xinput settings for Razer mouse every 5 seconds.";
            
            timerConfig = {
                OnBootSec = 0;
                OnUnitActiveSec = 5;
            };
            
            wantedBy = [ "timers.target" ];
        };

        systemd.user.services."xinput-razer-mouse" = {
            enable = true;
            description = "Sets xinput settings for Razer mouse.";
            
            serviceConfig = {
                Type = "simple";
                ExecStart = ''${config.ethorbit.scripts.xinput.razer-mouse.outPath}'';
            };
            
            wantedBy = [ "default.target" ];
        };
    };
}
