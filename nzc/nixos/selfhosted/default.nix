{ config, ... }:

{
    imports = [
        ../default.nix
        ./packages.nix
        ./networking
    ];
}
