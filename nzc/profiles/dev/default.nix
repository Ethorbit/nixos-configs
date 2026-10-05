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

    networking.hostName = "nzc-development";

    ethorbit.system.profile.name = "dev";
}
