{ config, ... }:

{
    services.openssh = {
        enable = true;

        listenAddresses = [
            {
                addr = config.ethorbit.workstation.network.host.ip;
                port = 22;
            }
        ];

        settings = {
            PermitRootLogin = "no";
        };
    };
}
