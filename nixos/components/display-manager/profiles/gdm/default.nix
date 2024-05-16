{ config, ... }:

{
    imports = [
        ../..
    ];

    services.xserver.displayManager.gdm.enable = true;
}
