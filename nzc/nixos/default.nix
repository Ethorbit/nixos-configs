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

    system.stateVersion = "23.11";
    
    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
