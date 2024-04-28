{ config, lib, ... }:

{
    # This will ensure that IPv6 is disabled in the kernel if it's disabled in networking.
    boot.kernelParams = lib.mkIf (config.networking.enableIPv6 == false) [ "ipv6.disable=1" ];

    networking = with lib; {
        # Since I've never needed IPv6 yet nor dealt with a system that needed it, 
        # I'm disabling it by default.
        enableIPv6 = mkDefault false;

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
