{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./audio
        ./containers
        ./packages
        ./users.nix
        ./services
        ./systemd.nix
        ./networking
        ./desktop.nix
        ./xorg.conf
        ./flatpak
        ./home-manager
        ../nixos/components/web-browsing/chromium/profiles/brave
        ../nixos/components/containers/docker
        ../nixos/components/programming/ide
        ../nixos/components/video-editing/profiles/kdenlive
        ../nixos/components/file-browser/profiles/nautilus
        ../nixos/components/gaming/steam/profiles/native

        ../nixos/components/networking/systemd
        #../nixos/components/service-discovery/profiles/avahi

        ./graphics.nix
        
        ../nixos/components/input-streaming/usbip
    ];

    networking.hostName = "workstation";
    #programs.virt-manager.enable = true;
    #virtualisation.libvirtd.enable = true;
    virtualisation.lxc.lxcfs.enable = true;

    ethorbit.programs.termdown-wrapper.soundPath = "/home/${config.ethorbit.users.primary.username}/Documents/timer.opus";
}
