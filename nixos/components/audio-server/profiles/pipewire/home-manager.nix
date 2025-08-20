{ homeModules, ... }:

{
    imports = [
        ../../../../home-manager/pipewire
    ];

    home-manager.sharedModules = [ homeModules.easyeffects ];
}
