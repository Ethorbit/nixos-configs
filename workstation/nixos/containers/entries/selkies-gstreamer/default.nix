{ config, ... }:

{
    imports = [
        ./users.nix
        ./networking.nix
        ./packages.nix
        ./desktop
    ];
}
