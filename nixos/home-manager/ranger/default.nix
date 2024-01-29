{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/ranger" = {
            source = ./config;
            recursive = true;
        };
    };
}
