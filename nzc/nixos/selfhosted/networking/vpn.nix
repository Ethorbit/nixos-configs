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
 
    systemd.network.networks."wg0" = {
        matchConfig = {
            Name = "wg0";
        };

        networkConfig = {
            Address = "10.66.66.2/32";
        };
    };
    
    systemd.network.netdevs = {
        "wg0" = {
            enable = true;

            netdevConfig = {
                Name = "wg0";
                Kind = "wireguard";
            };

            wireguardConfig = {
                PrivateKeyFile = config.age.secrets."networking/vpn/private.key".path;
                ListenPort = 58300;
            };

            wireguardPeers = [{
                wireguardPeerConfig = {
                    PublicKey = "tJczUpqDMK8LfLgd7PglO0mNsZcow3SS1SxyVncgs2E=";
                    PresharedKeyFile = config.age.secrets."networking/vpn/preshared.key".path;
                    AllowedIPs = [ "0.0.0.0/0" ];
                    Endpoint = "51.81.202.114:58300";
                    PersistentKeepalive = 25;
                };
            }];
        };
    };
}
