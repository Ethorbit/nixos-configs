{ config, ... }:

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./bootloader.nix
        ./packages.nix
        ./users.nix
        ./environment.nix
        ./timezone.nix
        ./home-manager
        ./services
        ./udev-rules.nix
        ./networking.nix
        ./sudo.nix
        ./libinput.nix
    ];

    age.identityPaths = [ config.ethorbit.age.identityPath ];

    programs.ssh.askPassword = "";
    programs.nano.enable = false;

    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
