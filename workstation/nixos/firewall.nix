{ config, ... }:

{
    networking.firewall = {
        enable = true;
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -I INPUT 1 -m state --state RELATED,ESTABLISHED -j ACCEPT
            iptables -I INPUT 2 -i lo -j ACCEPT
            iptables -I INPUT 3 -p tcp -m tcp --dport 22 -s ${config.ethorbit.network.admin.ip} -j ACCEPT
        '';
        extraStopCommands = ''
            iptables -P INPUT ACCEPT
        '';
    };
}
