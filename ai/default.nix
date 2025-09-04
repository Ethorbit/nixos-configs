{ ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./graphics.nix
        ./users.nix
        ./networking.nix
        ./services
        ./home-manager
        ../nixos/components/networking/systemd
        ../nixos/components/programming/ide
        ../nixos/components/containers/docker
    ];

    networking.hostName = "ai";
}
