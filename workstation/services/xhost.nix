{ pkgs, ... }:

with pkgs.xorg;

{
    systemd.user.services.xhost-allow-altuser = {
        description = "Allow alts to use the same X server";
        wantedBy = [ "default.target" ];
        serviceConfig = {
            Type = "oneshot";
            ExecStart = [
                "${xhost}/bin/xhost +SI:localuser:builder"
            ];
            Environment = "DISPLAY=:0";
        };
    };
}
