{ config, ... }:

{
    imports = [
        ./packages.nix
        ../..
        ../../../../home-manager/xfce
    ];

    programs.xfconf.enable = true;
    services.xserver.desktopManager.xfce.enable = true;
}
