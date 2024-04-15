{ config, ... }:

{
    imports = [
        ../..
        ../../../../home-manager/xfce
    ];

    programs.xfconf.enable = true;
    services.xserver.desktopManager.xfce.enable = true;
}
