{ config, pkgs, ... }:

{
    imports = [
        ./hardware.nix
        ./boot.nix
        ./packages
        ./users.nix
        ./services.nix
        ./networking
    ];
}
