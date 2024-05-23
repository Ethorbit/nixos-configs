{ config, lib, ... }:

{
    imports = [
        ../../../../../nixos/components/desktop-streaming/profiles/selkies-gstreamer
    ];

    age.secrets."selkies-gstreamer/password" = { file = ../secrets/selkies-gstreamer/pass.age; };

    # selkies-gstreamer runs as user and needs to read the secret
    environment.etc."coturn-secret".user = lib.mkForce config.ethorbit.users.primary.username;

    environment.etc."selkies-auth-password" = {
        source = config.age.secrets."selkies-gstreamer/password".path;
        user = config.ethorbit.users.primary.username;
    };

    ethorbit.components.selkies-gstreamer.settings = {
        turn = {
            host = "172.12.1.210";
            port = 3478;
            protocol = "udp";
            tls = true;
            sharedSecretFile = "/etc/coturn-secret";
        };

        auth = {
            passwordFile = "/etc/selkies-auth-password";
        };
    };
}
