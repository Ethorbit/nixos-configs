{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".wallpapers/dm_raven.jpeg" = {
            source = ./dm_raven.jpeg;
        };
    } ];
}
