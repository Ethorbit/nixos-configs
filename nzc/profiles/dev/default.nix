{ ... }:

{
    imports = [
        ../..
        ./hardware.nix
        ./packages.nix
        ./services.nix
        ./home-manager.nix
        ./networking.nix
    ];

    ethorbit.system.profile.name = "dev";
}
