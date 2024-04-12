{ config, ... }:

{
    imports = [
        ./firewall.nix
    ];

    boot.kernelParams = [ "ipv6.disable=1" ];

    # After what feels like 1,000 attempts at getting a DHCP bridge for ethernet working
    # I finally gave up and decided to add multiple virtual switches to my virtual machine 
    # instead, one for each container and then share the networkd config between host and container. 
    # It works great - each container has their own IP and interface.
    #
    # If the NixOS team ever gets around to fixing their systemd network shit, 
    # I'll attempt the "proper way" once again.
    #
    # (Basically the problem is Ethernet on its own works fine, but as soon as it connects to a bridge
    # there are no more IP assignments which means no internet. Static IP works, but that's not what I want)

    #systemd.network = {
        #enable = true;
        #wait-online.enable = false;

        #netdevs = {
        #    "20-br0" = {
        #        enable = true;
        #        netdevConfig = {
        #            Name = "br0";
        #            Kind = "bridge";
        #            Description = "Bridge for containers.";
        #        };
        #    };
        #};

        #networks = {
            #    "20-br0" = {
            #        matchConfig.Name = "br0";
            #        bridgeConfig = {};
            #        # linkConfig.RequiredForOnline = "routable";
            #    };
            #
            #    "30-eth0" = {
            #        matchConfig.Name = "eth0";
            #        networkConfig.DHCP = "yes";
            #        DHCP = "yes";
            #        gateway = [ config.ethorbit.network.router.defaultGateway ];
            #        dns = [ config.ethorbit.network.router.defaultGateway "1.1.1.1" ];
            #    
            #        dhcpV4Config = {
            #            UseDNS = true;
            #            UseRoutes = true;
            #        };
            #        
            #        networkConfig.Bridge = "br0";
            #        linkConfig.RequiredForOnline = "enslaved";
            #    };
        #};
    #};
}
