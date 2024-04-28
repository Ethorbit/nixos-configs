{ config, ... }:

{
    imports = [
        ../../../nixos/components/networking/systemd
        ./firewall.nix
    ];

    networking.enableIPv6 = false;

    systemd.network = {
        networks = {
            "20-eth0" = {
                matchConfig.Name = "eth0";
                DHCP = "no";
                gateway = [ config.networking.defaultGateway.address ];
                dns = [ config.networking.defaultGateway.address ];
                address = [ "192.168.254.222/24" ];
            };
        };
    };
}
