{ config, ... }:

{
    home-manager.sharedModules = [ {
        home.file.".imwheelrc" = {
            source = ./config/.imwheelrc
        };
    } ];
}
