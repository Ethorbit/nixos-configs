{ config, lib, ... }:

{
    networking = {
        useHostResolvConf = false;
        useNetworkd = true;
        useDHCP = false;
        defaultGateway = lib.mkForce {
            address = "172.16.1.1";
            interface = "eth0";
        };
    };

    systemd.network.networks."40-eth0" = {
        matchConfig.Name = "eth0";
        address = [ "172.16.1.211/24" ];
        gateway = [ config.networking.defaultGateway.address ];
        dns = [ config.networking.defaultGateway.address ];
        linkConfig.RequiredForOnline = "no";
    };
}
