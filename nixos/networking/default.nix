{ config, lib, ... }:

{
    networking = with lib; {
        # I am defaulting this to false since most people use a single
        # ethernet or wifi interface and it's a more pleasant
        # naming scheme to work with in that scenario (eth0, wlan0, etc)
        usePredictableInterfaceNames = mkDefault false;

        defaultGateway = {
            address = mkDefault "192.168.254.254";
            interface = mkDefault "";
        };

        nameservers = mkDefault [ config.networking.defaultGateway.address ];
    };
}
