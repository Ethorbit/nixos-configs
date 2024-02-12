{ config, ... }:

{
    imports = [
        ./packages.nix
        ./home-manager
    ];

    #services.openvscode-server.enable = true;
}
