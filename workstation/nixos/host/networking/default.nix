{ config, ... }:

{
    imports = [
        ./firewall.nix
    ];

    boot.kernelParams = [ "ipv6.disable=1" ];

    # Create a bridge and connect eth0 to it
    # This bridge can then be shared with containers
    systemd.network = {
        netdevs."20-br0" = {
            netdevConfig = {
                Kind = "bridge";
                Name = "br0";
            };
        };

        networks = {
            "30-eth0" = {
                DHCP = "no";
                matchConfig.Name = "eth0";
                networkConfig.Bridge = "br0";
                linkConfig.RequiredForOnline = "enslaved";
            };

            "40-br0" = {
                DHCP = "ipv4";
                dns = [ config.ethorbit.network.router.defaultGateway ];
                gateway = [ config.ethorbit.network.router.defaultGateway ];
                matchConfig.Name = "br0";
                bridgeConfig = {};
                linkConfig.RequiredForOnline = "carrier";
            };
        };
    };

    systemd.services.NetworkManager-wait-online.enable = false;
}
