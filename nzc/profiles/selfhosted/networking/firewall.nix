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
            iptables -F FORWARD 2>/dev/null || true
            iptables -F DOCKER-USER 2>/dev/null || true
            iptables -D INPUT -j NZC_INPUT 2>/dev/null || true
            iptables -D OUTPUT -j NZC_OUTPUT 2>/dev/null || true
            iptables -F NZC_INPUT 2>/dev/null || true
            iptables -F NZC_OUTPUT 2>/dev/null || true
            iptables -X NZC_INPUT 2>/dev/null || true
            iptables -X NZC_OUTPUT 2>/dev/null || true
            iptables -N NZC_INPUT
            iptables -N NZC_OUTPUT
            iptables -I INPUT 1 -j NZC_INPUT
            iptables -I OUTPUT 1 -j NZC_OUTPUT

            iptables -A FORWARD -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
            # LAN → containers
            iptables -A FORWARD -i eth0 -o docker0 -j ACCEPT
            # Containers -> Internet (Not LAN)
            iptables -A FORWARD -i docker0 -o eth0 ! -d 192.168.254.0/24 -j ACCEPT
            iptables -A FORWARD -i br+ -o eth0 ! -d 192.168.254.0/24 -j ACCEPT

            # VPN → containers
            iptables -A FORWARD -i wg0 -o docker0 -j ACCEPT
            iptables -A FORWARD -i wg0 -o br+ -j ACCEPT
            iptables -A FORWARD -i docker0 -o wg0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
            iptables -A FORWARD -i br+ -o wg0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT

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
            iptables -A DOCKER-USER -i wg0 -o br+ -p udp --dport 27000:28000 -j ACCEPT
            iptables -A DOCKER-USER -i wg0 -o br+ -p tcp --dport 27000:28000 -j ACCEPT
            iptables -A DOCKER-USER -j DROP
            iptables -A FORWARD -j DROP
        '';

        extraStopCommands = lib.mkForce ''
            iptables -P INPUT DROP
            iptables -P OUTPUT DROP
            iptables -D INPUT -j NZC_INPUT 2>/dev/null || true
            iptables -D OUTPUT -j NZC_OUTPUT 2>/dev/null || true
            iptables -F NZC_INPUT 2>/dev/null || true
            iptables -F NZC_OUTPUT 2>/dev/null || true
            iptables -X NZC_INPUT 2>/dev/null || true
            iptables -X NZC_OUTPUT 2>/dev/null || true
        '';
    };

    virtualisation.docker.daemon.settings.iptables = false;

    systemd.services.firewall = {
        after = [ "docker.service" ];
        requires = [ "docker.service" ];
    };
}
