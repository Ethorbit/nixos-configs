{ config, ... }:

{
    networking.firewall = {
        enable = true;
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -I INPUT 1 -p tcp -m tcp --dport 22 ! -s ${config.ethorbit.network.admin.ip} -j DROP
            iptables -A nixos-fw -p tcp -m tcp --dport 4713 -j nixos-fw-accept
        '';
        extraStopCommands = ''
            iptables -P INPUT ACCEPT
            iptables -F INPUT
        '';
    };
}
