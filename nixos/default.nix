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
    ];

    nix = with lib; {
        settings = {
            auto-optimise-store = mkDefault true;
            # Fixes 'warning: download buffer is full'
            # https://github.com/NixOS/nix/issues/11728
            download-buffer-size = 524288000;
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
