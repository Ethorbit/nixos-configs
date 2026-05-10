{ config, ... }:

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [
            config.ethorbit.nzc.sshd.port
        ];
    };
}
