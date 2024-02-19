{ config, ... }:

{
    imports = [
        ./nixpkgs
        ./options.nix
        ./packages.nix
        ./environment.nix
        ./timezone.nix
        ./home-manager
        ./services
    ];

    age.identityPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    nix.settings = {
        auto-optimise-store = true;
    };

    nix.extraOptions = ''
        experimental-features = nix-command flakes
    '';
}
