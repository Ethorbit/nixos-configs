{ config, pkgs, ... }:

{
    imports = [
        ./home-manager.nix
        ./packages.nix
    ];

    hardware.pulseaudio.enable = true;
}
