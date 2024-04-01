{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./users.nix
        ./services.nix
        ./firewall.nix
        ./containers
    ];
    
    networking.hostName = "workstation";
    security.sudo.wheelNeedsPassword = false;
}
