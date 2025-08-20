{ homeModules, ... }:

{
    home-manager.sharedModules = 
      with homeModules; [
        dconf
        gtk
        qt
    ];
}
