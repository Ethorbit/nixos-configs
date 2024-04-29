{ config, ... }:

{
    networking.firewall = {
        enable = true;
        extraCommands = ''
            iptables -P INPUT ACCEPT
            iptables -I nixos-fw 1 -s ${config.ethorbit.network.admin.ip} -j nixos-fw-accept
            iptables -A nixos-fw -s 172.25.0.0/16 -j nixos-fw-accept
        '';
    };
}
