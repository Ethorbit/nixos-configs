{ config, ... }:

{
    imports = [
        ../..
        ./packages.nix
    ];

    services.xserver.desktopManager.gnome.enable = true;
}
