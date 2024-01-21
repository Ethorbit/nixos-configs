{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        i3
        lightdm
        polybar
        firefox
        pulseaudio
    ];
}
