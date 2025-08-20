{ config, homeModules, ... }:

{
    home-manager.sharedModules = with homeModules; [
        flameshot
    ] ++ [ {
        ethorbit.home-manager.flameshot.saveDirectory = "/home/${config.ethorbit.users.primary.username}/Pictures";
    } ];
}
