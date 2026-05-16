{ config, ... }:

let
    cfgs = {
        vpn = config.ethorbit.nzc.network.vpn;
        eth = config.ethorbit.nzc.network.ethernet;
    };
in
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
                            Destination = cfgs.vpn.ip.public.addressCIDR;
                            Gateway = cfgs.eth.gateway;
                        };
                    }
                    {
                        routeConfig = {
                            Destination = "192.168.0.0/16";
                            Gateway = cfgs.eth.gateway;
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
                            Address = cfgs.vpn.ip.private.addressCIDR;
                        };
                    }
                ];

                routes = [
                    {
                        routeConfig = {
                            Destination = "0.0.0.0/0";
                        };
                    }
                    {
                        routeConfig = {
                            Destination = cfgs.vpn.ip.private.subnet;
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
                    ListenPort = cfgs.vpn.port;
                };

                wireguardPeers = [{
                    wireguardPeerConfig = {
                        PublicKey = config.ethorbit.nzc.network.vpn.publicKey;
                        PresharedKeyFile = config.age.secrets."networking/vpn/preshared.key".path;
                        AllowedIPs = [ "0.0.0.0/0" ];
                        Endpoint = "${cfgs.vpn.ip.public.address}:${cfgs.vpn.port}";
                        PersistentKeepalive = 25;
                    };
                }];
            };
        };
    };
}
