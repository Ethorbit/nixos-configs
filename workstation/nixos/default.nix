{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./host-and-containers
        ./bootloader.nix
        ./users.nix
        ./services.nix
        ./firewall.nix
        ./containers
    ];

    networking.hostName = "workstation";
}
