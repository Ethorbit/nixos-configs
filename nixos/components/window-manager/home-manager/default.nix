{ config, homeModules, ... }:

{
    home-manager.sharedModules =
      with homeModules; [
        dunst
        feh
        flameshot
        kitty
        moc
        polybar
        picom
        ranger
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
