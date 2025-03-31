{ config, pkgs, ... }:

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
        ./xorg.conf
        ./flatpak
        ./home-manager
        ../../nixos/components/web-browsing/chromium/profiles/brave
        ../../nixos/components/containers/docker
        ../../nixos/components/programming/ide
        ../../nixos/components/file-browser/profiles/nautilus

        ../../nixos/components/networking/systemd
        #../../nixos/components/service-discovery/profiles/avahi

        ../../nixos/components/graphics-drivers/opengl
        ../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
        ../../nixos/components/graphics-drivers/nvidia/profiles/cuda
        
        # Suffers from weird issues such as flickers, also it's less secure
        # to give games full access to user files.
        #../../nixos/components/gaming/steam/profiles/native
        #../../nixos/components/gaming/lutris/profiles/native
    
        ../../nixos/components/input-streaming/usbip
    ];

    networking.hostName = "workstation";
    #programs.virt-manager.enable = true;
    #virtualisation.libvirtd.enable = true;

    ethorbit.graphics.nvidia.proprietary.selectedPackage = config.boot.kernelPackages.nvidiaPackages.stable;

    ethorbit.termdown-wrapper.soundPath = "/home/${config.ethorbit.users.primary.username}/Documents/timer.opus";
}
