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
                            Gateway = config.networking.defaultGateway.address;
                            Destination = config.ethorbit.nzc.vpn.ip;
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
                            Address = "${config.ethorbit.nzc.vpn.privateCIDR}";
                        };
                    }
                ];

                routes = [
                    {
                        routeConfig = {
                            Destination = "${config.ethorbit.nzc.vpn.privateCIDR}";
                        };
                    }
                    {
                        routeConfig = {
                            Gateway = "${config.ethorbit.nzc.vpn.defaultGateway}";
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
                    ListenPort = config.ethorbit.nzc.vpn.port;
                };

                wireguardPeers = [{
                    wireguardPeerConfig = {
                        PublicKey = "WNLcxvGnKkhWOs111G4/WYkz2AzTlXFytTYNqTsiLQ8=";
                        PresharedKeyFile = config.age.secrets."networking/vpn/preshared.key".path;
                        AllowedIPs = [ "10.66.66.0/24" ];
                        Endpoint = "${config.ethorbit.nzc.vpn.ip}:${config.ethorbit.nzc.vpn.port}";
                        PersistentKeepalive = 25;
                    };
                }];
            };
        };
    };
}
