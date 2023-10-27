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
			iptables -A INPUT -i enp2s0 -j ACCEPT
			iptables -A INPUT -i virbr0 -j ACCEPT
			iptables -A INPUT -i br-wired -s 192.168.254.0/24 -j ACCEPT
			iptables -A INPUT -j LOG
			iptables -A INPUT -j LIBVIRT_INP

			iptables -A LIBVIRT_FWI -d 192.168.122.0/24 -o virbr0 -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
			iptables -A LIBVIRT_FWI -o virbr0 -j REJECT --reject-with icmp-port-unreachable
			iptables -A LIBVIRT_FWO -s 192.168.122.0/24 -i virbr0 -j ACCEPT
			iptables -A LIBVIRT_FWO -i virbr0 -j REJECT --reject-with icmp-port-unreachable
			iptables -A LIBVIRT_FWX -i virbr0 -o virbr0 -j ACCEPT
			iptables -A LIBVIRT_INP -i virbr0 -p icmp -j ACCEPT
			iptables -A LIBVIRT_INP -i virbr0 -p udp -m udp -m multiport --dports 137,138 -j ACCEPT
			iptables -A LIBVIRT_INP -i virbr0 -p tcp -m tcp -m multiport --dports 139,445 -j ACCEPT
			iptables -A LIBVIRT_INP -i virbr0 -p udp -m udp --dport 53 -j ACCEPT
			iptables -A LIBVIRT_INP -i virbr0 -p tcp -m tcp --dport 53 -j ACCEPT
			iptables -A LIBVIRT_INP -i virbr0 -p udp -m udp --dport 67 -j ACCEPT
			iptables -A LIBVIRT_INP -i virbr0 -p tcp -m tcp --dport 67 -j ACCEPT
			
			iptables -A BR_WIRED_AI_FW -j LOG
			iptables -A BR_WIRED_AI_FW -s 0.0.0.0 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -d 192.168.254.38 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -d 192.168.254.43 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -d 192.168.254.48 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -d 192.168.254.39 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -p udp --sport 123 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -p udp --dport 123 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -m multiport -p tcp --sports 80,443 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -p udp --sport 53 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -m multiport -p tcp --dports 80,443 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -p udp --dport 53 -j ACCEPT
			iptables -A BR_WIRED_AI_FW -j DROP
			
			iptables -A FORWARD -i br-wired -o enp2s0 -j ACCEPT
			iptables -A FORWARD -i enp2s0 -o br-wired -j ACCEPT
			iptables -A FORWARD -m mac --mac-source 52:54:00:a0:0d:4e -i br-wired -o br-wired -j BR_WIRED_AI_FW
			iptables -A FORWARD -j LIBVIRT_FWX
			iptables -A FORWARD -j LIBVIRT_FWI
			iptables -A FORWARD -j LIBVIRT_FWO
		'';
	};
}
