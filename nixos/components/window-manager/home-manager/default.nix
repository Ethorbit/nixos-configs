{ config, ... }:

{
    imports = [
        ./desktop-scripts
        ../../../home-manager/polybar
        ../../../home-manager/picom
        ../../../home-manager/dunst
        ../../../home-manager/kitty
        ../../../home-manager/moc
        ../../../home-manager/flameshot
    ];
}
