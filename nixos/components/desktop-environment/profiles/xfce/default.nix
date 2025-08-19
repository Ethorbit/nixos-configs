{ homeModules, ... }:

{
    imports = [
        ./packages.nix
        ../..
    ];

    home-manager.sharedModules = [ homeModules.xfconf ];
    programs.xfconf.enable = true;
    services.xserver.desktopManager.xfce.enable = true;
}
