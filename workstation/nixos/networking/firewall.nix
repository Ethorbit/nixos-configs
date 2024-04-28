{ config, ... }:

{
    networking.firewall = {
        extraCommands = ''
            iptables -I INPUT 1 -s ${config.ethorbit.network.admin.ip} -j ACCEPT
        '';
    };
}
