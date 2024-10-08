{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        qt = {
            enable = true;
            #platformTheme = "gnome";
            platformTheme.name = "adwaita";
            style = {
                name = "adwaita-dark";
            };
        };
    } ];
}
