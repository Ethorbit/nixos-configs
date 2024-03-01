{ config, ... }:

{
    # This might need to be tweaked, it's not compatible for everyone's setup.
    imports = [
        ./firewall.nix
    ];

    systemd.network.enable = true;

    networking = {
        useDHCP = false;
        useNetworkd = true;
        usePredictableInterfaceNames = false;
        resolvconf = {
            enable = true;
        };
    };

    environment.etc."resolv.conf".text = ''
    # Created with environment.etc.'resolv.conf' NixOS option
    nameserver ${config.ethorbit.network.router.defaultGateway}
    options edns0
    '';

    systemd.network.networks."eth0" = {
        matchConfig.Name = "eth0";
        networkConfig.DHCP = "ipv4";
    };
}
