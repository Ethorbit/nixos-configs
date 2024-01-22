{ config, ... }:

{
    imports = [
        ./users.nix
        ./packages.nix
        ./home-manager
    ];

    system.stateVersion = "23.11";
}
