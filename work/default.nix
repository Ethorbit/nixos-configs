{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./desktop.nix
        ./audio.nix
        ./networking.nix
        ./packages.nix
        ./flatpak.nix
        ./services.nix
        ./users.nix
        ../nixos/components/web-browsing/chromium/profiles/brave
        ../nixos/components/programming/ide
        ../nixos/components/containers/podman
    ];

    networking.hostName = "work-pc";
}
