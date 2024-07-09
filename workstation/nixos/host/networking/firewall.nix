{ config, lib, ... }:

with lib;
let
    containerIPs = map (name: "${config.ethorbit.workstation.containers.entries.${name}.ip}") (attrNames config.ethorbit.workstation.containers.entries);
in
{
    networking.firewall = {
        enable = false;
        allowedTCPPorts = [ 22 80 443 4713 ]; # SSH, Traefik, Pulseaudio
        
    # The fake exit code 0s are due to the custom chain commands exiting with error code 1 even though they succeed.
    # I have no idea why they do this and it causes the firewall service to fail, so the fake exit 0 is my workaround.
    # Everything seems to get added fine now. \o/
        extraCommands = ''
            ip6tables -P INPUT DROP
            ip6tables -P OUTPUT DROP
            ip6tables -P FORWARD DROP

            iptables -N INPUT_CONTAINERS 2> /dev/null || (exit 0)
            iptables -P INPUT DROP
            iptables -P INPUT_CONTAINERS DROP 2> /dev/null || (exit 0)

            # By default, SSH is allowed by any system. We only need the central admin system to SSH.
            iptables -I INPUT 1 -p tcp -m tcp --dport 22 ! -s ${config.ethorbit.network.admin.ip} -j DROP

            # Send incoming container connections to the container chain
            ${toString (map (ip: ''
            iptables -I INPUT 2 -s ${ip} -j INPUT_CONTAINERS
            '') containerIPs)}

            # Block container connection to host's reverse proxy (as it's used to connect to other containers)
            iptables -I INPUT_CONTAINERS 1 -p tcp -m multiport --dports 80,443 -j DROP

            iptables -I INPUT_CONTAINERS 2 -j ACCEPT
        '';

        extraStopCommands = ''
            iptables -P INPUT_CONTAINERS ACCEPT 2> /dev/null || (exit 0)
            iptables -F INPUT_CONTAINERS 2> /dev/null || (exit 0)
            iptables -P INPUT ACCEPT
            iptables -F INPUT
        '';
    };
}
