{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".wallpapers/dm_raven.jpeg" = {
            source = ./dm_raven.jpeg;
        };
    };
}
