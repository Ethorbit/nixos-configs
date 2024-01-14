{ config, lib, ... }:

{
    options = with lib; {
        custom.vpn = {
            ip = mkOption {
                type = types.str;
                default = "51.81.202.114";
            };

            port = mkOption {
                type = types.str;
                default = "58300";
            };
        };
    };
    
    config = {
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
                                Gateway = "192.168.254.254";
                                Destination = config.custom.vpn.ip;
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
                                Address = "10.66.66.2/24";
                            };
                        }
                    ];

                    routes = [
                        {
                            routeConfig = {
                                Destination = "10.66.66.0/24";
                            };
                        }
                        {
                            routeConfig = {
                                Gateway = "10.66.66.1";
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
                        ListenPort = config.custom.vpn.port;
                    };

                    wireguardPeers = [{
                        wireguardPeerConfig = {
                            PublicKey = "tJczUpqDMK8LfLgd7PglO0mNsZcow3SS1SxyVncgs2E=";
                            PresharedKeyFile = config.age.secrets."networking/vpn/preshared.key".path;
                            AllowedIPs = [ "0.0.0.0/0" ];
                            Endpoint = "${config.custom.vpn.ip}:${config.custom.vpn.port}";
                            PersistentKeepalive = 25;
                        };
                    }];
                };
            };
        };
    };
}
