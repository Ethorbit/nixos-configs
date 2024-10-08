{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".wallpapers/pb_z_high_school.jpeg" = {
            source = ./pb_z_high_school.jpeg;
        };
    } ];
}
