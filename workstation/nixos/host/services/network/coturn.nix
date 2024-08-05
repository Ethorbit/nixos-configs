{ config, lib, ... }:

{
    services.coturn = {
        enable = true;
        realm = config.networking.hostName;
        relay-ips = [ "${config.ethorbit.workstation.network.host.ip}" ];
        listening-ips = [ "0.0.0.0" ];
        listening-port = 3478;
        min-port = 49152;
        max-port = 65535;
        use-auth-secret = true;
        static-auth-secret-file = "/etc/coturn-secret";
        no-cli = true;
        no-tls = true;
        no-dtls = true;
        extraConfig = ''
            channel-lifetime=-1
            external-ip "${config.ethorbit.workstation.network.host.ip}"
            fingerprint
            allow-loopback-peers
        '';
    };

    # COTURN runs as its own user, so we have to give it permissions to the secret.
    environment.etc."coturn-secret" = {
        user = lib.mkForce "turnserver";
        group = lib.mkForce "turnserver";
    };
}
