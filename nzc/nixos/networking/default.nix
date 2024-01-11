{ config, ... }:

{
    imports = [
        ./firewall.nix
    ];

    systemd.network.enable = true;

    networking = {
        useDHCP = false;
        useNetworkd = true;
        usePredictableInterfaceNames = false;
    };

    # This might need to be tweaked, it's not compatible for everyone's setup.
    systemd.network.networks."eth0" = {
        matchConfig.Name = "eth0";
        networkConfig.DHCP = "ipv4";
    };
}
