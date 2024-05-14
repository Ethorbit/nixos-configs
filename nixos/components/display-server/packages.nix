{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        glib
        papirus-icon-theme
    ];
}
