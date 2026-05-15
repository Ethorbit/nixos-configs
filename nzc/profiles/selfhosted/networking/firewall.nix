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
            iptables -D INPUT -j NZC_INPUT 2>/dev/null || true
            iptables -D FORWARD -j NZC_FORWARD 2>/dev/null || true
            iptables -D OUTPUT -j NZC_OUTPUT 2>/dev/null || true
            iptables -F NZC_INPUT 2>/dev/null || true
            iptables -F NZC_FORWARD 2>/dev/null || true
            iptables -F NZC_OUTPUT 2>/dev/null || true
            iptables -X NZC_INPUT 2>/dev/null || true
            iptables -X NZC_FORWARD 2>/dev/null || true
            iptables -X NZC_OUTPUT 2>/dev/null || true
            iptables -N NZC_INPUT
            iptables -N NZC_FORWARD
            iptables -N NZC_OUTPUT
            iptables -I INPUT 1 -j NZC_INPUT
            iptables -I OUTPUT 1 -j NZC_OUTPUT
            iptables -I FORWARD 1 -j NZC_FORWARD

            iptables -A NZC_FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

            # block containers → RFC1918 ranges
            iptables -A NZC_FORWARD -s 172.16.0.0/12 -d 10.0.0.0/8 -j DROP
            iptables -A NZC_FORWARD -s 172.16.0.0/12 -d 192.168.0.0/16 -j DROP

            # container → internet
            iptables -A NZC_FORWARD -s 172.16.0.0/12 -o eth0 -j ACCEPT

            # block VPN -> RFC1918 LAN range
            iptables -A NZC_FORWARD -i wg0 -d 192.168.0.0/16 -j DROP

            # VPN → containers
            iptables -A NZC_FORWARD -i wg0 -d 172.16.0.0/12 -j ACCEPT
            iptables -A NZC_FORWARD -s 172.16.0.0/12 -o wg0 -j ACCEPT

            iptables -A NZC_INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
            iptables -A NZC_INPUT -i lo -j ACCEPT
            iptables -A NZC_INPUT -i wg0 -j DROP
            iptables -A NZC_INPUT -i eth0 -p tcp -m tcp --dport ${config.ethorbit.nzc.network.sshd.port} -s 192.168.254.0/24 -j ACCEPT
            iptables -A NZC_INPUT -i eth0 -p udp -m udp --dport ${config.ethorbit.nzc.network.vpn.port} -j ACCEPT
            iptables -A NZC_INPUT -i eth0 -j DROP

            iptables -A NZC_OUTPUT -m conntrack --ctstate INVALID -j DROP
            iptables -A NZC_OUTPUT -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
            iptables -A NZC_OUTPUT -o lo -j ACCEPT
            iptables -A NZC_OUTPUT -o wg0 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p udp -m udp --dport ${config.ethorbit.nzc.network.vpn.port} -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p udp -m udp --dport 53 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p tcp -m tcp --dport 53 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p tcp -m tcp --dport 80 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p tcp -m tcp --dport 443 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -p udp -m udp --dport 123 -j ACCEPT
            iptables -A NZC_OUTPUT -o eth0 -j DROP

            # VPN -> game servers
            iptables -A DOCKER-USER -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
            iptables -A DOCKER-USER -i wg0 -p udp --dport 27000:28000 -j ACCEPT
            iptables -A DOCKER-USER -i wg0 -p tcp --dport 27000:28000 -j ACCEPT
            iptables -A DOCKER-USER -j DROP
        '';

        extraStopCommands = lib.mkForce ''
            iptables -P INPUT DROP
            iptables -P OUTPUT DROP
            iptables -D INPUT -j NZC_INPUT 2>/dev/null || true
            iptables -D FORWARD -j NZC_FORWARD 2>/dev/null || true
            iptables -D OUTPUT -j NZC_OUTPUT 2>/dev/null || true
            iptables -F NZC_INPUT 2>/dev/null || true
            iptables -F NZC_FORWARD 2>/dev/null || true
            iptables -F NZC_OUTPUT 2>/dev/null || true
            iptables -X NZC_INPUT 2>/dev/null || true
            iptables -X NZC_FORWARD 2>/dev/null || true
            iptables -X NZC_OUTPUT 2>/dev/null || true
        '';
    };

    systemd.services.firewall = {
        after = [ "docker.service" ];
        requires = [ "docker.service" ];
    };
}
