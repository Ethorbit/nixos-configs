{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.dunst.enable = true;
        home.file.".config/dunst" = {
            source = ./config;
            recursive = true;
        };
    } ];
}
