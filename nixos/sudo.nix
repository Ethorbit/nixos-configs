{ config, pkgs, ... }:

{
    security.sudo.extraRules = [
        {
            groups = [ "power" ];
            commands = [
                { command = "${config.system.path}/bin/poweroff"; options = [ "NOPASSWD" ]; }
                { command = "${config.system.path}/bin/reboot"; options = [ "NOPASSWD" ]; }
                { command = "${config.system.path}/bin/systemctl suspend"; options = [ "NOPASSWD" ]; }
                { command = "${config.system.path}/bin/shutdown"; options = [ "NOPASSWD" ]; }
                { command = "${config.system.path}/bin/halt"; options = [ "NOPASSWD" ]; }
            ];
        }
    ];
}
