{ config, pkgs, ... }:

let
    cfg = config.ethorbit.components.recording.obs.sockets;
in
{
    systemd.services = {
        "obs-capture-server" = {
            enable = cfg.capture.server.enable;
            wantedBy = [ "multi-user.target" ];
            description = "OBS Capture Socket";
            serviceConfig = {
                RuntimeDirectory = "obs-capture";
                ExecStart = "${pkgs.socat}/bin/socat UNIX-LISTEN:/run/obs-capture/obs-capture.sock,fork,reuseaddr,mode=666 ABSTRACT-CONNECT:/com/obsproject/vkcapture";
                Restart = "always";
                RestartSec = "2s";
                User = cfg.capture.user;
            };
        };

        "obs-capture-client" = {
            enable = cfg.capture.client.enable;
            description = "Listen to our OBS socket";
            wantedBy = [ "multi-user.target" ];
            serviceConfig = {
                ExecStart = "${pkgs.socat}/bin/socat ABSTRACT-LISTEN:/com/obsproject/vkcapture,fork,reuseaddr UNIX-CONNECT:/run/obs-capture/obs-capture.sock";
                Restart = "on-failure";
                RestartSec = "5s";
                User = cfg.capture.user;
            };
        };
    };
}
