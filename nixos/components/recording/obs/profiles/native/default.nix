# TODO: actually test this..

{ lib, pkgs, ... }:

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
        ] ++ mkIf services.pipewire.enable [
            obs-pipewire-audio-capture
        ] ++ mkIf hardware.pulseaudio.enable [
            obs-pulseaudio-app-capture
        ];
    };
}
