{ config, lib, pkgs, ... }:

with lib;

{
    imports = [
        ../../.
        ./home-manager.nix
    ];

    programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
            obs-vkcapture
        ] ++ mkIf services.pipewire.enable [
            obs-pipewire-audio-capture
        ] ++ mkIf hardware.pulseaudio.enable [
            # TODO: add my NixOS port of pulseaudio-audio-capture
        ];
    };
}
