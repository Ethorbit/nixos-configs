{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".wallpapers/dm_coldruins_rc1.jpeg" = {
            source = ./dm_coldruins_rc1.jpeg;
        };
    } ];
}
