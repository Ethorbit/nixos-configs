{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./host-and-containers
        ./bootloader.nix
        ./users.nix
        ./services.nix
        ./networking
        ./desktop.nix
        ./packages.nix
        ../../nixos/components/programming/ide
        ./containers
    ];

    networking.hostName = "workstation";
}
