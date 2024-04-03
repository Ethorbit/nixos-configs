{ config, ... }:

{
    imports = [
        ../..
        ./packages.nix
    ];

    services.xserver.desktopManager.cinnamon.enable = true;
}
