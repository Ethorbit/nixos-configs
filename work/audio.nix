{ config, pkgs, ... }:

{
    imports = [
        ../nixos/components/audio-server/profiles/pulseaudio
    ];

    hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
