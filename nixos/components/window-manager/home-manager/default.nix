{ config, homeModules, ... }:

{
    imports = [
        ../../../home-manager/dunst
        ../../../home-manager/kitty
        ../../../home-manager/moc
        ../../../home-manager/ranger
    ];

    home-manager.sharedModules =
      with homeModules; [
        feh
        flameshot
        polybar
        picom
        rofi
    ] ++ [
        {
            ethorbit.home-manager.flameshot.saveDirectory = "/home/${config.ethorbit.users.primary.username}/Pictures";

            ethorbit.home-manager.xdg.defaults = {
                file = "ranger.desktop";
                audio = "moc.desktop";
            };
        }
    ];
}
