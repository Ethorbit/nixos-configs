{ config, ... }:

{
    imports = [
        ./packages.nix
        ./home-manager
        ./services.nix
    ];
}
