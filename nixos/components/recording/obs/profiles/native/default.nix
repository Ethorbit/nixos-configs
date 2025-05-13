# TODO: actually test this..

{ config, lib, pkgs, ... }:

with lib;

{
    imports = [
        ../../.
        ./home-manager.nix
        ../../../../packages/c/obs-pulseaudio-app-capture
    ];

    programs.obs-studio = {
        enable = true;
        plugins = with pkgs.obs-studio-plugins; [
            obs-vkcapture
        ] ++ mkIf services.pipewire.enable [
            obs-pipewire-audio-capture
        ] ++ mkIf hardware.pulseaudio.enable [
            config.ethorbit.pkgs.c.obs-pulseaudio-app-capture
        ];
    };
}
