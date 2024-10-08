{ config, ... }:

{
    home-manager.sharedModules = [ {
        programs.kitty = {
            enable = true;
        };

        home.file.".config/kitty" = {
            source = ./config;
            recursive = true;
        };
    } ];
}
