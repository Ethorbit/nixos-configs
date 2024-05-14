{ config, ... }:

{
    imports = [
        ./packages.nix
        ./fonts.nix
        ./home-manager.nix
        ./xdg.nix
    ];
}
