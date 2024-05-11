{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        xfce.xfce4-whiskermenu-plugin
        xfce.xfce4-docklike-plugin
    ];
}
