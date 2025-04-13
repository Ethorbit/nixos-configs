{ config, pkgs, ... }:

{
    imports = [
        ../../../../packages/python/watch-xfce-xfconf
    ];

    environment.systemPackages = with pkgs; with xfce; [
        config.ethorbit.pkgs.python.watch-xfce-xfconf
        xfce4-whiskermenu-plugin
        xfce4-docklike-plugin
        xfce4-timer-plugin
    ];
}
