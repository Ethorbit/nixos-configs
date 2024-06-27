{ config, lib, ... }:

{
    hardware.pulseaudio = with lib; {
        enable = mkDefault true;
        zeroconf.publish.enable = true;

        tcp = {
            enable = true;
            anonymousClients = {
                #allowAll = true;
                allowedIpRanges = [ "127.0.0.0/8" ];
            };
        };

        daemon.config = {
            realtime-scheduling = "yes";
        };
    };
}
