{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".wallpapers/pb_z_high_school.jpeg" = {
            source = ./pb_z_high_school.jpeg;
        };
    };
}
