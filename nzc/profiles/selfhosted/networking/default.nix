{ config, lib, ... }:

{
    imports = [
        ./options.nix
        ./vpn.nix
        ./firewall.nix
    ];

    systemd.network.networks."eth0" = {
        addresses = [
            {
                addressConfig.Address = "192.168.254.225/24";
            }
        ];

        routes = [
            {
                routeConfig.Gateway = "192.168.254.254";
            }
        ];
    };

    ethorbit.nzc.sshd.port = "22";
    services.openssh.listenAddresses = [
        {
            addr = "192.168.254.225";
            port = lib.toInt config.ethorbit.nzc.sshd.port;
        }
    ];
}
