{ config, ... }:

{
    imports = [
        ./users.nix
        ./desktop
        ./networking.nix
        ./environment.nix
    ];
}
