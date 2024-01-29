{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        gnome.adwaita-icon-theme
        gnomeExtensions.appindicator
    ];

    environment.gnome.excludePackages = (with pkgs; [
        gnome-photos
        gnome-tour
    ]) ++ (with pkgs.gnome; [
        cheese
        gnome-music
        gnome-terminal
        gedit
        epiphany
        geary
        evince
        gnome-characters
        totem
        tali
        iagno
        hitori
        atomix 
    ]);
}
