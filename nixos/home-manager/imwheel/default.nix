{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".imwheelrc" = {
            source = ./config/.imwheelrc
        };
    };
}
