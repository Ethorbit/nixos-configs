{ config, lib, ... }:

{
    hardware.pulseaudio = with lib; {
        enable = mkDefault true;
        extraConfig = ''
            unload-module module-suspend-on-idle
        '';

        zeroconf.publish.enable = true;

        tcp = {
            enable = true;
            anonymousClients = {
                allowAll = true;
                allowedIpRanges = [ "127.0.0.1/8" ];
            };
        };

        daemon.config = {
            allow-exit = "no";
            exit-idle-time = "-1";
            realtime-scheduling = "yes";
        };
    };
}
