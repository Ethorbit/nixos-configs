{ config, ... }:

{
    networking.firewall = {
        extraCommands = ''
            iptables -P INPUT DROP
            iptables -I nixos-fw 1 -s ${config.ethorbit.network.admin.ip} -j nixos-fw-accept
            iptables -A nixos-fw -s 172.0.0.0/24 -j nixos-fw-accept
        '';
    };
}
