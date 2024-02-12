{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".wallpapers/dm_coldruins_rc1.jpeg" = {
            source = ./dm_coldruins_rc1.jpeg;
        };
    };
}
