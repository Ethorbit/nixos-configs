{ config, pkgs, ... }:

{
    imports = 
    [
       ./firewall.nix
    ];

    networking = {
        usePredictableInterfaceNames = false;
    
        networkmanager = {
            enable = true;
            dns = "none";
        };

        nameservers = [ 
            "1.1.1.1"
            "1.0.0.1"
            "192.168.254.254"
        ];
    };

    environment.etc = {
        "NetworkManager/system-connections/br-wired-port.nmconnection" = {
            mode = "0600";
            text = ''
                [connection]
`               id=br-wired-port
                uuid=3c7e302b-d082-4ad2-901c-99bd62676134
                type=ethernet
                interface-name=eth0
                master=253203db-c363-42bc-88d9-6e9bd8a808d3
                slave-type=bridge

                [ethernet]

                [bridge-port]
            '';
        };

        "NetworkManager/system-connections/br-wired.nmconnection" = {
            mode = "0600";
            text = ''
                [connection]
                id=br-wired
                uuid=253203db-c363-42bc-88d9-6e9bd8a808d3
                type=bridge
                interface-name=br-wired
                timestamp=1691028307

                [ethernet]

                [bridge]

                [ipv4]
                address1=192.254.224.1/24,192.168.254.254
                dns=1.1.1.1;1.0.0.1;
                method=auto

                [ipv6]
                addr-gen-mode=default
                method=auto

                [proxy]
            '';
        };
    };
}
