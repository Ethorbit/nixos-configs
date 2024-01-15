{ config, ... }:

{
    age.secrets."networking/firewall/ISP_CIDR_one.age" = {
        file = ../secrets/networking/firewall/ISP_CIDR_one.age;
    };

    age.secrets."networking/firewall/ISP_CIDR_two.age" = {
        file = ../secrets/networking/firewall/ISP_CIDR_two.age;
    };

    networking.firewall = {
        enable = true;
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -P OUTPUT ACCEPT
            iptables -P FORWARD DROP
            iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
            iptables -A INPUT -i lo -j ACCEPT
            iptables -A OUTPUT -o lo -j ACCEPT
            iptables -A INPUT -i eth0 -m tcp -p tcp --dport 53 -j ACCEPT
            iptables -A INPUT -i eth0 -m udp -p udp --dport 53 -j ACCEPT
            iptables -A INPUT -i eth0 -s 192.168.254.1/24 -j ACCEPT
            iptables -A INPUT -s $(cat ${config.age.secrets."networking/firewall/ISP_CIDR_one.age".path}) -j ACCEPT
            iptables -A INPUT -s $(cat ${config.age.secrets."networking/firewall/ISP_CIDR_two.age".path}) -j ACCEPT
        '';
    };
}
