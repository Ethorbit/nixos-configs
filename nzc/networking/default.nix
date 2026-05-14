{ ... }:

let
    dns = [
        "1.1.1.1"
        "1.0.0.1"
        "8.8.8.8"
        "8.8.4.4"
        "9.9.9.9"
    ];
in
{
    imports = [
        ./firewall.nix
    ];

    networking = {
        nameservers = [];
        useDHCP = false;
    };

    systemd.network.networks."eth0" = {
        matchConfig.Name = "eth0";
        networkConfig = {
            DHCP = false;
            DNS = dns;
        };
    };

    virtualisation.docker.daemon.settings.dns = dns;
}
