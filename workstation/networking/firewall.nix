{ config, lib, ... }:

with lib;

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 22 ]; # SSH

        extraCommands = ''
            iptables -P INPUT DROP
            ip6tables -P INPUT DROP
            ip6tables -P OUTPUT DROP
            ip6tables -P FORWARD DROP

            # nzc
            iptables -I INPUT 1 -i wg-nzc -p tcp --dport 2222 -j ACCEPT
            iptables -I INPUT 2 -i wg-nzc -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
            iptables -I INPUT 3 -i wg-nzc -j DROP
            iptables -I OUTPUT 1 -o wg-nzc -p tcp --dport 2222 -j ACCEPT
            iptables -I OUTPUT 2 -o wg-nzc -m conntrack --ctstate RELATED,ESTABLISHED -j ACCEPT
            iptables -I OUTPUT 3 -o wg-nzc -j DROP

            # By default, SSH is allowed by any system. We only need the central admin system to SSH.
            iptables -I INPUT 4 -p tcp -m tcp --dport 22 ! -s ${config.ethorbit.network.admin.ip} -j DROP
        '';

        extraStopCommands = ''
            iptables -P INPUT ACCEPT
            iptables -F INPUT
            iptables -F OUTPUT
        '';
    };
}
