{ config, lib, ... }:

{
    networking.firewall = {
        enable = lib.mkForce true;

        # Manually managed using commands instead
        allowedTCPPorts = lib.mkForce [];
        allowedUDPPorts = lib.mkForce [];

        extraCommands = lib.mkForce ''
            # Essentials
            iptables -P INPUT DROP
            iptables -P OUTPUT DROP
            iptables -P FORWARD DROP
            iptables -N NZC_INPUT
            iptables -N NZC_OUTPUT
            iptables -N GAMESERVERS
            iptables -I INPUT 1 -j NZC_INPUT
            iptables -I OUTPUT 1 -j NZC_OUTPUT

            iptables -A NZC_INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
            iptables -A NZC_INPUT -i lo -j ACCEPT
            iptables -A NZC_INPUT -i eth0 -p tcp -m tcp -s 192.168.254.0/24 --dport ${config.ethorbit.nzc.sshd.port} -j ACCEPT
            iptables -A NZC_INPUT -i eth0 -p udp -m udp --dport ${config.ethorbit.nzc.vpn.port} -j ACCEPT
            iptables -A NZC_INPUT -i eth0 -j DROP
            iptables -A NZC_INPUT -i wg0 -j GAMESERVERS

            iptables -A NZC_OUTPUT -m conntrack --ctstate INVALID -j DROP
            iptables -A NZC_OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
            iptables -A NZC_OUTPUT -o lo -j ACCEPT
            iptables -A NZC_OUTPUT -o wg0 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p udp -m udp --dport 53 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p tcp -m tcp --dport 53 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p tcp -m tcp --dport 80 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p tcp -m tcp --dport 443 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p udp -m udp --dport 123 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -j DROP


            # Gameserver Hosting
            iptables -A GAMESERVERS -p udp -m udp --dport 27000:27050 -j ACCEPT
            iptables -A GAMESERVERS -p udp -m udp --dport 27018:28018 -j ACCEPT
            iptables -A GAMESERVERS -j DROP
        '';

        extraStopCommands = lib.mkForce ''
            iptables -P INPUT DROP
            iptables -P OUTPUT DROP
            iptables -F NZC_INPUT
            iptables -F NZC_OUTPUT
        '';
    };
}
