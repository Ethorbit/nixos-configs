{ config, lib, ... }:

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./bootloader.nix
        ./packages
        ./flatpak.nix
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

    nix = with lib; {
        settings = {
            auto-optimise-store = mkDefault true;
        };

        gc = {
            automatic = mkDefault true;
            dates = mkDefault "weekly";
            options = mkDefault "--delete-generations +50";
        };

        extraOptions = ''
            experimental-features = nix-command flakes
        '';
    };
}
