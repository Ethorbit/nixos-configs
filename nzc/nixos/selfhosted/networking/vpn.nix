{ config, lib, ... }:

{
    options = with lib; {
        ethorbit = {
            nzc.vpn = {
                ip = mkOption {
                    type = types.str;
                    default = "51.81.202.114";
                };

                port = mkOption {
                    type = types.str;
                    default = "58300";
                };

                defaultGateway = mkOption {
                    type = types.str;
                    default = "10.66.66.1";
                };
                
                privateCIDR = mkOption {
                    type = types.str;
                    default = "10.66.66.2/24";
                };
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
                                Gateway = config.ethorbit.network.router.defaultGateway;
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
                            PublicKey = "tJczUpqDMK8LfLgd7PglO0mNsZcow3SS1SxyVncgs2E=";
                            PresharedKeyFile = config.age.secrets."networking/vpn/preshared.key".path;
                            AllowedIPs = [ "0.0.0.0/0" ];
                            Endpoint = "${config.ethorbit.nzc.vpn.ip}:${config.ethorbit.nzc.vpn.port}";
                            PersistentKeepalive = 25;
                        };
                    }];
                };
            };
        };
    };
}
