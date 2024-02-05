{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.easyeffects.enable = true;
    };
}
