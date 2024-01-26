{ config, ... }:

{
    home-manager.users.ide = {
        programs.kitty = {
            enable = true;
        };

        home.file.".config/kitty" = {
            source = ./config;
            recursive = true;
        };
    };
}
