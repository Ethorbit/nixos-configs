{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./host-and-containers
        ./bootloader.nix
        ./users.nix
        ./services.nix
        ./networking
        ./containers
    ];

    networking.hostName = "workstation";
}
