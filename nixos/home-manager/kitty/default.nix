{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.kitty = {
            enable = true;
        };

        home.file.".config/kitty" = {
            source = ./config;
            recursive = true;
        };
    };
}
