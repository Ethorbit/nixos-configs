{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".config/pipewire" = {
            source = ./config;
            recursive = true;
        };
    } ];
}
