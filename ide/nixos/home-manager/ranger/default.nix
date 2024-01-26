{ config, ... }:

{
    home-manager.users.ide = {
        home.file.".config/ranger" = {
            source = ./config;
            recursive = true;
        };
    };
}
