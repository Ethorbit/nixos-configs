{ homeModules, ... }:

{
    imports = [
        ../../home-manager/qt
    ];

    home-manager.sharedModules = 
      with homeModules; [
        dconf
        gtk
    ];
}
