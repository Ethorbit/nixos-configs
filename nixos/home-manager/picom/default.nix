{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/picom" = {
            source = ./config;
            recursive = true;
        };

        services.picom.enable = true;
    };
}
