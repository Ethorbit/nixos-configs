{ config, ... }:

{
    imports = [
        ./packages
        ./home-manager
        ./services.nix
    ];
}
