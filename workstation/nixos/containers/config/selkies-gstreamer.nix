{ config, lib, ... }:

{
    imports = [
        ../../../../nixos/components/desktop-streaming/profiles/selkies-gstreamer
    ];

    # selkies-gstreamer runs as user and needs to read the secret
    environment.etc."coturn-secret".user = lib.mkForce config.ethorbit.users.primary.username;
}
