{ config, ... }:

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 80 443 4713 ];
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -I INPUT 1 -p tcp -m tcp --dport 22 ! -s ${config.ethorbit.network.admin.ip} -j DROP
        '';
        extraStopCommands = ''
            iptables -P INPUT ACCEPT
            iptables -F INPUT
        '';
    };
}
