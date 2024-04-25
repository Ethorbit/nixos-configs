{ config, ... }:

{
    # This is so that our containers can send their audio to us
    hardware.pulseaudio = {
        zeroconf.publish.enable = true;

        tcp = {
            enable = true;
            anonymousClients.allowedIpRanges = [ config.ethorbit.network.router.LAN.CIDR ];
        };
    };
}
