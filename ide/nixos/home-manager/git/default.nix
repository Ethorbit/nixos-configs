{ config, ... }:

{
    home-manager.users.ide = {
        programs.git = {
            enable = true;
        };

        home.file.".gitconfig" = {
            source = ./config/.gitconfig;
        };
    };
}
