{ config, pkgs, ... }:

{
    imports = [
        ./home-manager.nix
        ./packages.nix
    ];

    hardware.pulseaudio = {
        enable = true;
        extraConfig = "unload-module module-suspend-on-idle";
    };
}
