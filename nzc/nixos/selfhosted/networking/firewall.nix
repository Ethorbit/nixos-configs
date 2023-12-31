{ config, ... }:

{
    networking.firewall = {
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -P OUTPUT DROP
            iptables -P FORWARD DROP
            iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
            iptables -A INPUT -i lo -j ACCEPT
            iptables -A INPUT -i eth0 -s 192.168.254.1/24 -j ACCEPT
            iptables -A OUTPUT -o eth0 -d 192.168.254.1/24 -j ACCEPT
            iptables -A INPUT -i wg0 -j ACCEPT
            iptables -A OUTPUT -o wg0 -j ACCEPT
        '';
    };
}
