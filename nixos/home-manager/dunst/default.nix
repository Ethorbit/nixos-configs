{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/dunst" = {
            source = ./config;
            recursive = true;
        };
    
        services.dunst.enable = true;
    };
}
