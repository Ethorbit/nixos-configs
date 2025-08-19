{ homeModules, ... }:

{
    imports = [
        ../../../home-manager/feh
        ../../../home-manager/picom
        ../../../home-manager/dunst
        ../../../home-manager/kitty
        ../../../home-manager/moc
        ../../../home-manager/ranger
        ../../../home-manager/flameshot
    ];

    home-manager.sharedModules = 
      with homeModules; [
        polybar
        rofi
    ];

    ethorbit.home-manager.xdg.defaults = {
        file = "ranger.desktop";
        audio = "moc.desktop";
    };
}
