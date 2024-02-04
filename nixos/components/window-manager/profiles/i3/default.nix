{ config, ... }:

{
    imports = [
        ../..
        ./home-manager.nix
        ./packages.nix
        ./services.nix
    ];

    services.xserver.windowManager.i3.enable = true;
}
