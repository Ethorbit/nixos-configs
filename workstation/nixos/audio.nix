{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/components/audio-server/profiles/pulseaudio
    ];

    hardware.pulseaudio = {
        zeroconf.discovery.enable = true;
        package = pkgs.pulseaudioFull;
    };
}
