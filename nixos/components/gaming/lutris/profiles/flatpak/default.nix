# See home-manager.nix for more info

{ config, pkgs, ... }:

{
    imports = [
        ../../../dependencies/profiles/flatpak
        ./options.nix
        ./home-manager.nix
    ];
}
