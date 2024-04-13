{ config, ... }:

{
    imports = [
        ./firewall.nix
    ];

    boot.kernelParams = [ "ipv6.disable=1" ];

    # Redundant, results in secondary DHCP IP
    #systemd.network = {
    #    networks = {
    #        "20-eth" = {
    #            matchConfig.Name = "eth0";
    #            DHCP = "ipv4";
    #        };
    #    };
    #};
}
