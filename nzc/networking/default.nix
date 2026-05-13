{ ... }:

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
            DNS = [
                "1.1.1.1"
                "1.0.0.1"
                "8.8.8.8"
                "8.8.4.4"
            ];
        };
    };
}
