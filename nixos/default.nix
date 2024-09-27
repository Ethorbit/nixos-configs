{ config, lib, ... }:

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./bootloader.nix
        ./packages
        ./programs
        ./users.nix
        ./timezone.nix
        ./locale.nix
        ./home-manager
        ./services
        ./udev-rules.nix
        ./networking.nix
        ./sudo.nix
        ./libinput.nix
    ];

    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
