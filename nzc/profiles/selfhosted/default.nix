{ config, ... }:

{
    imports = [
        ../..
        ./hardware.nix
        ./packages.nix
        ./networking
        ./nix-docker-deployment
    ];

    ethorbit.system.profile.name = "selfhosted";
}
