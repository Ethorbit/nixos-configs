{ config, lib, ... }:

{
    systemd.network = {
        enable = true;
        wait-online.enable = false;
    };

    networking = {
        nameservers = [ config.ethorbit.network.router.defaultGateway ];

        # Predictable names won't even work for some reason. 
        # If it becomes necessary, I'll just set the interface names manually.
        # It should be ok anyway since I am just using DHCP for everything.
        #predictableInterfaceNames = lib.mkForce true;

        enableIPv6 = false;
        dhcpcd.enable = false;
        useNetworkd = true;
        useDHCP = lib.mkForce false;

        defaultGateway.address = config.ethorbit.network.router.defaultGateway;
        defaultGateway.interface = "";

        useHostResolvConf = false; # needed to use resolved
    };

    services.resolved.enable = true;
}
