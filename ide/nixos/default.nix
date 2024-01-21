{ config, ... }:

{
    imports = [
        ./users.nix
        ./packages.nix
        ./services.nix
    ];
}
