{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./users.nix
        ./audio.nix
        ./services.nix
        ./networking
        ./desktop.nix
        ./packages.nix
        ./home-manager.nix
        ../../../nixos/components/containers/docker
        ../../../nixos/components/display-nesting/profiles/xephyr
        ../../../nixos/components/programming/ide
    ];

    networking.hostName = "workstation";
}
