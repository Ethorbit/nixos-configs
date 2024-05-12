{ config, ... }:

{
    imports = [
        ./packages.nix
        ../..
        ../../../../home-manager/xfconf
    ];

    programs.xfconf.enable = true;
    services.xserver.desktopManager.xfce.enable = true;
}
