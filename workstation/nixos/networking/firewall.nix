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

            # By default, SSH is allowed by any system. We only need the central admin system to SSH.
            iptables -I INPUT 1 -p tcp -m tcp --dport 22 ! -s ${config.ethorbit.network.admin.ip} -j DROP
        '';

        extraStopCommands = ''
            iptables -P INPUT ACCEPT
            iptables -F INPUT
        '';
    };
}
