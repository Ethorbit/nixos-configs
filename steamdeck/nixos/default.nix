{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./users.nix
        ./networking.nix
        ./services.nix
        ./packages
        ./flatpak.nix
        ./desktop.nix
        ./home-manager
        ../../nixos/components/programming/ide
        ../../nixos/components/containers/podman
        ../../nixos/components/web-browsing/chromium
    ];

    jovian.steam = {
        enable = true;
        autoStart = true;
        # see desktop.nix
        desktopSession = "xfce";
        # see users.nix
        user = "${config.ethorbit.users.primary.username}";
    };
}
