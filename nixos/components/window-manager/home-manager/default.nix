{ config, ... }:

{
    imports = [
        ../../../home-manager/feh
        ../../../home-manager/polybar
        ../../../home-manager/rofi
        ../../../home-manager/picom
        ../../../home-manager/dunst
        ../../../home-manager/kitty
        ../../../home-manager/moc
        ../../../home-manager/ranger
        ../../../home-manager/flameshot
    ];

    ethorbit.home-manager.xdg.defaults = {
        file = "ranger.desktop";
        audio = "moc.desktop";
    };
}
