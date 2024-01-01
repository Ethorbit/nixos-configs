{ config, pkgs, ... }:

{
    networking.firewall = {
        enable = true;
        extraCommands = ''
            ip6tables -P INPUT DROP
            ip6tables -P OUTPUT DROP
            ip6tables -P FORWARD DROP
            iptables -P INPUT DROP
        
            ip6tables -F
            ip6tables -X
            iptables -F
            iptables -X
            
            iptables -N nixos-fw-log-refuse
            iptables -N nixos-fw-accept
            iptables -N nixos-fw-refuse
            iptables -N LIBVIRT_FWI
            iptables -N LIBVIRT_FWO
            iptables -N LIBVIRT_FWX
            iptables -N LIBVIRT_INP
            iptables -N BR_WIRED_AI_FW
            
            iptables -A INPUT -m state --state RELATED,ESTABLISHED -j ACCEPT
            iptables -A INPUT -i lo -j ACCEPT
            iptables -A INPUT -i eth0 -j ACCEPT
            iptables -A INPUT -i virbr0 -j ACCEPT
            iptables -A INPUT -i br-wired -s 192.168.254.0/24 -j ACCEPT
            iptables -A INPUT -j LOG
            iptables -A INPUT -j LIBVIRT_INP

            iptables -A FORWARD -i br-wired -o eth0 -j ACCEPT
            iptables -A FORWARD -i eth0 -o br-wired -j ACCEPT
            iptables -A FORWARD -j LIBVIRT_FWX
            iptables -A FORWARD -j LIBVIRT_FWI
            iptables -A FORWARD -j LIBVIRT_FWO
        '';
    };
}
