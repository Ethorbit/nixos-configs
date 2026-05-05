{ config, ... }:

{
    networking.firewall = {
        enable = true;
        
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -P OUTPUT ACCEPT
            iptables -P FORWARD ACCEPT
            iptables -N NIXOS_INPUT
            iptables -I INPUT 1 -j NIXOS_INPUT
            iptables -A NIXOS_INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
            iptables -A NIXOS_INPUT -i lo -j ACCEPT
            iptables -A NIXOS_INPUT -i eth0 -m tcp -p tcp --dport ${config.ethorbit.nzc.sshd.port} -j ACCEPT
            iptables -A NIXOS_INPUT -i eth0 -s 192.168.254.0/24 -j ACCEPT
        '';
        
        extraStopCommands = ''
            iptables -P INPUT ACCEPT
            iptables -D NIXOS_INPUT
        '';
    };
}
