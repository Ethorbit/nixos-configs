{ config, ... }:

{
    home-manager.users.ide = {
        home.file.".config/i3" = {
            source = ./config;
            recursive = true;
        };
    };
}
