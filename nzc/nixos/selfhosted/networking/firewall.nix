{ config, ... }:

{
    networking.firewall = {
        extraCommands = ''
            iptables -P INPUT ACCEPT
            iptables -P OUTPUT ACCEPT
            iptables -P FORWARD DROP
            iptables -F
            iptables -X
            iptables -t nat -F
            iptables -t nat -X
            iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
            iptables -A INPUT -i lo -j ACCEPT
            iptables -A OUTPUT -o lo -j ACCEPT
            iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
            iptables -A FORWARD -i eth0 -o wg0 -j ACCEPT
            iptables -A FORWARD -i wg0 -o eth0 -j ACCEPT
        '';
        #iptables -A INPUT -i wg0 -j DROP
        #iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        
        #extraCommands = ''
        #    iptables -P INPUT DROP
        #    iptables -P OUTPUT DROP
        #    iptables -P FORWARD DROP
        #    iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
        #    iptables -A INPUT -i lo -j ACCEPT
        #    iptables -A OUTPUT -o lo -j ACCEPT
        #    iptables -A INPUT -i eth0 -s 192.168.254.1/24 -j ACCEPT
        #    iptables -A OUTPUT -o eth0 -d 192.168.254.1/24 -j ACCEPT
        #    iptables -A INPUT -i wg0 -j ACCEPT
        #    iptables -A OUTPUT -o wg0 -j ACCEPT
        #    iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
        #    iptables -t nat -A POSTROUTING -o wg0 -j MASQUERADE
        #    iptables -A FORWARD -i eth0 -o wg0 ! -d 192.168.254.1/24 -j ACCEPT
        #    iptables -A FORWARD -i wg0 -o eth0 ! -d 192.168.254.1/24 -j ACCEPT
        #'';
    };
}
