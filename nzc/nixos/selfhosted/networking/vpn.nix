{ config, lib, ... }:

{
    age.secrets."networking/vpn/ip" = { file = ../secrets/networking/vpn/ip.age; };
    age.secrets."networking/vpn/private.key" = { file = ../secrets/networking/vpn/private.key.age; };

    networking.wireguard.interfaces."wg0" = {
        ips = [ "10.66.66.2/24" ];
        listenPort = 51820;
        privateKeyFile = (builtins.readFile age.secrets."networking/vpn/privateKey".path);
        endpoint = ''${(builtins.readFile age.secrets."networking/vpn/ip".path)}:51820'';
        persistentKeepalive = 25;
    };
}
