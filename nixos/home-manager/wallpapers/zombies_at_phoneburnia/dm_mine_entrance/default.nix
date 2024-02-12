{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".wallpapers/dm_mine_entrance.jpeg" = {
            source = ./dm_mine_entrance.jpeg;
        };
    };
}
