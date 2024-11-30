{ config, lib, ... }:

with lib;

{
    imports = [
        ./firewall.nix
        ./hosts.nix
    ];

    options.ethorbit.workstation.network = {
        host.ip = mkOption {
            type = types.str;
            default = "172.16.1.210";
        };
    };

    config = {
        # Private bridge interface, Gateway VM
        networking.defaultGateway.address = "172.16.1.1";

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
                    address = [ "${config.ethorbit.workstation.network.host.ip}/24" ];
                    dns = [ config.networking.defaultGateway.address ];
                    gateway = [ config.networking.defaultGateway.address ];
                    matchConfig.Name = "br0";
                    bridgeConfig = {};
                    linkConfig.RequiredForOnline = "carrier";
                };
            };
        };

        # Gateway handles DNS fallbacks already.
        services.resolved.fallbackDns = [ ];
    };
}
