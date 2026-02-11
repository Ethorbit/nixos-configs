{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/components/audio-server/profiles/pulseaudio
        ./obs.nix
    ];

    hardware.pulseaudio = {
        zeroconf.discovery.enable = true;
        package = pkgs.pulseaudioFull;
        # Local socket for containers
        extraConfig = ''
            load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/pulse
        '';
    };
}
