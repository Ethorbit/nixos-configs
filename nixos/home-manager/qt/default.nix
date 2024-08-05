{ config, pkgs, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        qt = {
            enable = true;
            #platformTheme = "gnome";
            platformTheme.name = "adwaita";
            style = {
                name = "adwaita-dark";
            };
        };
    };
}
