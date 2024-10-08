{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".config/ranger" = {
            source = ./config;
            recursive = true;
        };
    } ];
}
