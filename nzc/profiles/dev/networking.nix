{ ... }:

{
    networking.defaultGateway.address = "172.16.1.1";

    systemd.network.networks."eth0" = {
        address = [ "172.16.1.222/24" ];
        # address = [ "192.168.254.222/24" ];
    };

    environment.etc."resolv.conf".text = ''
    # Created with environment.etc.'resolv.conf' NixOS option
    nameserver 127.0.0.1
    options trust-ad
    '';
}
