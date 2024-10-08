{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".wallpapers/dm_mine_entrance.jpeg" = {
            source = ./dm_mine_entrance.jpeg;
        };
    } ];
}
