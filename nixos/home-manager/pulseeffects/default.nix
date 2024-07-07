{ config, lib, ... }:

with lib;
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.pulseeffects = {
            enable = mkDefault true;
            preset = "Main";
        };

        home.file.".config/PulseEffects" = {
            source = ./config;
            recursive = true;
        };
    };
}
