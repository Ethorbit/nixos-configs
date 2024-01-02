{ config, ... }

{
    networking.firewall = {
        enable = true;
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -P OUTPUT ACCEPT
            iptables -P FORWARD DROP
            iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
            iptables -A INPUT -i lo -j ACCEPT
            iptables -A INPUT -m tcp -p tcp --dport 2222 -j ACCEPT
        '';
    };
}
