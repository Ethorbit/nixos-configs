{ config, ... }:

{
    systemd.network.networks."eth0" = {
        address = [ "192.168.254.222/24" ];
    };

    environment.etc."resolv.conf".text = ''
    # Created with environment.etc.'resolv.conf' NixOS option
    nameserver 127.0.0.1
    options trust-ad
    '';
}
