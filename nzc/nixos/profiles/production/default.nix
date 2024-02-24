{ config, ... }:

{
    imports = [
        ../..
        ./hardware.nix
    ];

    ethorbit.system.profile.name = "production";
}
