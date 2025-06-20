{ pkgs, ... }:

{
    environment.systemPackages = 
        with pkgs;
        with xfce;
        with ethorbit.xfce;
    [
        watch-xfce-xfconf
        xfce4-whiskermenu-plugin
        xfce4-docklike-plugin
        xfce4-timer-plugin
    ];
}
