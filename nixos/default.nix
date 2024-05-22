{ config, ... }:

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./bootloader.nix
        ./packages.nix
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

    age.identityPaths = [ config.ethorbit.age.identityPath ];
    
    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
