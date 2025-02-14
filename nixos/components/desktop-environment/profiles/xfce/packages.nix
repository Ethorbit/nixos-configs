{ config, pkgs, ... }:

{
    imports = [
        ../../../../packages/python/watch-xfce-xfconf
    ];

    environment.systemPackages = with pkgs; [
        config.ethorbit.pkgs.python.watch-xfce-xfconf
        xfce.xfce4-whiskermenu-plugin
        xfce.xfce4-docklike-plugin
    ];
}
