{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        cinnamon-common
        gnome-keyring
    ];
}
