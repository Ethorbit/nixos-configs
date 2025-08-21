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
        networking = {
            usePredictableInterfaceNames = true;

            # Private bridge interface, Gateway VM
            defaultGateway.address = "172.16.1.1";
        };

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
                # Host network bridge, only available when needed
                "20-enp6s19" = {
                    DHCP = "yes";
                    matchConfig.Name = "enp6s19";
                    dns = [ "192.168.254.254" ];
                    gateway = [ "192.168.254.254" ];
                };

                # Work network bridge
                "30-enp6s18" = {
                    DHCP = "no";
                    matchConfig.Name = "enp6s18";
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

                # For USB/IP
                "100-enp6s20" = {
                    DHCP = "no";
                    matchConfig.Name = "enp6s20";
                    address = [ "172.200.1.150/24" ];
                };
            };
        };

        # Gateway handles DNS fallbacks already.
        services.resolved.fallbackDns = [ ];
    };
}
