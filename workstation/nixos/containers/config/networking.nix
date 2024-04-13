{ config, lib, ... }:

{
    networking.firewall.enable = lib.mkForce false;

    # Redundant, results in secondary DHCP IP
    #systemd.network = {
    #    networks = {
    #        "20-eth" = {
    #            matchConfig.Name = "eth*";
    #            DHCP = "ipv4";
    #        };
    #    };
    #};
}
