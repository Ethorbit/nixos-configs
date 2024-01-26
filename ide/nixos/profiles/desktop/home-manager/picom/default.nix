{ config, ... }:

{
    home-manager.users.ide = {
        home.file.".config/picom" = {
            source = ./config;
            recursive = true;
        };

        services.picom.enable = true;
    };
}
