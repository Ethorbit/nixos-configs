{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".desktop-once" = {
            source = ./.desktop-once;
            executable = true;
        };

        home.file.".desktop-always" = {
            source = ./.desktop-always;
            executable = true;
        };
    };
}
