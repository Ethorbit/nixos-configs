{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/polybar" = {
            source = ./config;
            recursive = true;
        };

        services.polybar.script = "";
        services.polybar.enable = true;
    };
}
