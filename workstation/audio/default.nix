{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/components/audio-server/profiles/pulseaudio
        ./obs.nix
    ];

    hardware.pulseaudio = {
        zeroconf.discovery.enable = true;
        package = pkgs.pulseaudioFull;
    };
}
