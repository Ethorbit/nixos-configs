{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.pulseeffects.enable = true;
    };
}
