{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./users.nix
        ./services.nix
        ./networking
        ./desktop.nix
        ./packages.nix
        ./audio.nix
        ../../../nixos/components/display-nesting/profiles/xephyr
        ../../../nixos/components/programming/ide
    ];

    networking.hostName = "workstation";
}
