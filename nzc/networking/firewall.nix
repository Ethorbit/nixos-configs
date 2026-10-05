{ config, ... }:

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [
            config.ethorbit.nzc.network.sshd.port
        ];
    };
}
