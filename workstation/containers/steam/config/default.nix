{ ... }:

{
    imports = [
        ./users.nix
        ./networking
        ./audio.nix
        ./packages.nix
        ./environment-variables.nix
        ./home-manager.nix
    ];
}
