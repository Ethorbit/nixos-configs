{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./graphics.nix
        ./audio
        ./packages
        ./users.nix
        ./systemd.nix
        ./containers
        ./networking
        ./desktop.nix
        ./xorg.conf
        ./flatpak
        ./home-manager
        ../nixos/components/networking/systemd
        ../nixos/components/input-streaming/usbip
        ../nixos/components/containers/docker
        ../nixos/components/web-browsing/chromium/profiles/brave
        ../nixos/components/programming/ide
        ../nixos/components/file-browser/profiles/nautilus
        ../nixos/components/recording/obs/profiles/native
        ../nixos/components/video-editing/profiles/kdenlive
        ../nixos/components/gaming/steam/profiles/native
        #../nixos/components/service-discovery/profiles/avahi
    ];

    networking.hostName = "workstation";
    virtualisation.lxc.lxcfs.enable = true;

    ethorbit.programs.termdown-wrapper.soundPath = "/home/${config.ethorbit.users.primary.username}/Documents/timer.opus";
}
