{ homeModules, ... }:

{
    home-manager.sharedModules = 
        with homeModules; [
            pipewire
            easyeffects
        ];
}
