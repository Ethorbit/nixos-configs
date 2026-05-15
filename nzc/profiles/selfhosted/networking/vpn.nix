{ config, lib, ... }:

{
    age.secrets."networking/vpn/private.key" = {
        file = ../secrets/networking/vpn/private.key.age;
        owner = "systemd-network";
    };
    
    age.secrets."networking/vpn/preshared.key" = {
        file = ../secrets/networking/vpn/preshared.key.age;
        owner = "systemd-network";
    };
    
    systemd.network = {
        networks = {
            "eth0" = {
                routes = [
                    {
                        routeConfig = {
                            Gateway = config.ethorbit.nzc.network.ethernet.gateway;
                            Destination = config.ethorbit.nzc.network.vpn.ip.public;
                        };
                    }
                ];
            };
        
            "wg0" = {
                matchConfig = {
                    Name = "wg0";
                };

                addresses = [
                    {
                        addressConfig = {
                            Address = "${config.ethorbit.nzc.network.vpn.ip.privateCIDR}";
                        };
                    }
                ];

                routes = [
                    {
                        routeConfig = {
                            Destination = "10.66.66.0/24";
                        };
                    }
                ];
            };
        };

        netdevs = {
            "wg0" = {
                enable = true;

                netdevConfig = {
                    Name = "wg0";
                    Kind = "wireguard";
                    Description = "Wireguard tunnel";
                };

                wireguardConfig = {
                    PrivateKeyFile = config.age.secrets."networking/vpn/private.key".path;
                    ListenPort = config.ethorbit.nzc.network.vpn.port;
                };

                wireguardPeers = [{
                    wireguardPeerConfig = {
                        PublicKey = "WNLcxvGnKkhWOs111G4/WYkz2AzTlXFytTYNqTsiLQ8=";
                        PresharedKeyFile = config.age.secrets."networking/vpn/preshared.key".path;
                        AllowedIPs = [ "10.66.66.0/24" ];
                        Endpoint = "${config.ethorbit.nzc.network.vpn.ip.public}:${config.ethorbit.nzc.network.vpn.port}";
                        PersistentKeepalive = 25;
                    };
                }];
            };
        };
    };
}
