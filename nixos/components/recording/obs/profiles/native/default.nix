{ config, lib, pkgs, ... }:

with lib;

{
    imports = [
        ../../.
        ./home-manager.nix
    ];

    programs.obs-studio = {
        enable = true;
        plugins =
            with pkgs;
            with obs-studio-plugins;
            with ethorbit.obs-studio-plugins; 
        [
            obs-vkcapture
        ] ++ (if config.services.pipewire.enable then [
            obs-pipewire-audio-capture
        ] else []) ++ (if config.hardware.pulseaudio.enable then [
            obs-pulseaudio-app-capture
        ] else []);
    };
}
