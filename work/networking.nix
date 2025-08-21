{ config, lib, ... }:

with lib;

{
    networking = {
        hostName = "work-pc";
        interfaces.wlan0 = {};
        defaultGateway.interface = "wlan0";
        networkmanager.enable = true;

        firewall = {
            enable = true;
            allowedTCPPorts = [ 22 ]; # SSH

            extraCommands = ''
                iptables -P INPUT DROP
                ip6tables -P INPUT DROP
                ip6tables -P OUTPUT DROP
                ip6tables -P FORWARD DROP

                iptables -I INPUT 1 -p tcp -m tcp --dport 22 -j ACCEPT
            '';

            extraStopCommands = ''
                iptables -P INPUT ACCEPT
                iptables -F INPUT
            '';
        };
    };
}
