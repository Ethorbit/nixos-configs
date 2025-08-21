{ config, ... }:

{
    imports = [
        ../..
        ./hardware.nix
        ./packages.nix
        ./networking
    ];

    ethorbit.system.profile.name = "selfhosted";
}
