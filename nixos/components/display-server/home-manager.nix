{ homeModules, ... }:

{
    imports = [
        ../../home-manager/gtk
        ../../home-manager/qt
    ];

    home-manager.sharedModules = 
      with homeModules; [
        dconf
    ];
}
