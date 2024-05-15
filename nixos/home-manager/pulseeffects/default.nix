{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.pulseeffects = {
            enable = true;
            preset = "Main";
        };

        home.file.".config/PulseEffects" = {
            source = ./config;
            recursive = true;
        };
    };
}
