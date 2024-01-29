{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/flameshot" = {
            source = ./config;
            recursive = true;
        };

        services.flameshot.enable = true;
    };
}
