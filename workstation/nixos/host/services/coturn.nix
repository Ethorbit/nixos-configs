{ config, lib, ... }:

{
    
    services.coturn = {
        enable = true;
        realm = config.networking.hostName;
        listening-port = 3478;
        min-port = 49160;
        max-port = 49200;
        use-auth-secret = true;
        static-auth-secret-file = "/etc/coturn-secret";
        no-cli = true;
        extraConfig = ''
            --fingerprint
            --allow-loopback-peers
        '';
    };

    # COTURN runs as its own user, so we have to give it permissions to the secret.
    environment.etc."coturn-secret" = {
        user = lib.mkForce "turnserver";
        group = lib.mkForce "turnserver";
    };
}
