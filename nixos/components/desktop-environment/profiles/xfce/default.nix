{ config, ... }:

{
    imports = [
        ../..
    ];

    services.xserver.desktopManager.xfce.enable = true;
}
