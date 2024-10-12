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
        ../../../nixos/components/web-browsing/chromium
        ../../../nixos/components/containers/docker
        ../../../nixos/components/display-nesting/profiles/xephyr
        ../../../nixos/components/programming/ide
        ../../../nixos/components/file-browser/profiles/nautilus
    ];

    networking.hostName = "workstation";
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;

    ethorbit.termdown-wrapper.soundPath = "/home/${config.ethorbit.users.primary.username}/Documents/timer.opus";
}
