{ config, ... }:

{
    imports = [
        ./home-manager
        ./packages.nix
        ./services.nix
    ];

    services.xserver.windowManager.i3.enable = true;
}
