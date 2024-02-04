{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".moc" = {
            source = ./config;
            recursive = true;
        };
    };
}
