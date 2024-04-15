{ config, lib, ... }:

{
    networking.firewall.enable = lib.mkForce false;

    systemd.network = {
        networks = {
            "20-eth" = {
                matchConfig.Name = "eth*";
                DHCP = "ipv4";
            };
        };
    };
}
