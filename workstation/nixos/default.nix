{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./audio.nix
        ./packages
        ./users.nix
        ./services
        ./systemd.nix
        ./networking
        ./desktop.nix
        ./flatpak.nix
        ./home-manager
        ../../nixos/components/web-browsing/chromium
        ../../nixos/components/containers/docker
        ../../nixos/components/programming/ide
        ../../nixos/components/file-browser/profiles/nautilus

        ../../nixos/components/gaming/mod-manager/nexus

        ../../nixos/components/networking/systemd
        #../../nixos/components/service-discovery/profiles/avahi

        ../../nixos/components/graphics-drivers/opengl
        ../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
        ../../nixos/components/graphics-drivers/nvidia/profiles/cuda
    ];

    networking.hostName = "workstation";
    #programs.virt-manager.enable = true;
    #virtualisation.libvirtd.enable = true;

    ethorbit.termdown-wrapper.soundPath = "/home/${config.ethorbit.users.primary.username}/Documents/timer.opus";
}
