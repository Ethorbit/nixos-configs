{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        qt = {
            enable = true;
            platformTheme = "gnome";
            style = {
                name = "adwaita-dark";
            };
        };
    };
}
