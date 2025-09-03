{ config, lib, ... }:

with lib;

{
    options.ethorbit.ai.network = {
        host.ip = mkOption {
            type = types.str;
            default = "172.16.1.205";
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
                # Work network bridge
                "30-ens18" = {
                    DHCP = "no";
                    matchConfig.Name = "ens18";
                    networkConfig.Bridge = "br0";
                    linkConfig.RequiredForOnline = "enslaved";
                };

                "40-br0" = {
                    address = [ "${config.ethorbit.ai.network.host.ip}/24" ];
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
