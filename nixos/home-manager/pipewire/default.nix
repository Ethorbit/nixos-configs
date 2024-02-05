{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/pipewire" = {
            source = ./config;
            recursive = true;
        };
    };
}
