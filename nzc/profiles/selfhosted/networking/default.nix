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
                addressConfig.Address = "${config.ethorbit.nzc.network.ethernet.ip}/24";
            }
        ];

        routes = [
            {
                routeConfig.Gateway = config.ethorbit.nzc.network.ethernet.gateway;
            }
        ];
    };

    ethorbit.nzc.network.sshd.port = "22";
    # this creates a race condition that locks the sysadmin out
    # it is completely useless, just use the firewall
    # services.openssh.listenAddresses = [
    #     {
    #         addr = config.ethorbit.nzc.network.ethernet.ip;
    #         port = 22;
    #     }
    # ];
}
