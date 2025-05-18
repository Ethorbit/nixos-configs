{ config, pkgs, ... }:

{
    imports = [
        ./options.nix
        ./service.nix
    ];
}
