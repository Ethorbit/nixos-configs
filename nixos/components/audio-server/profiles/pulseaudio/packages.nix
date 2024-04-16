{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        pulseaudio
        pavucontrol
    ];
}
