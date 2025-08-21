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
        ../nixos/components/programming/ide
        ../nixos/components/containers/podman
        ../nixos/components/web-browsing/chromium/profiles/brave
        ../nixos/components/desktop-streaming/profiles/sunshine
    ];

    jovian = {
        steamos.useSteamOSConfig = true;

        steam = {
            enable = true;
            autoStart = true;
            # see desktop.nix and home-manager/desktop.nix
            desktopSession = "xfce";
            # see users.nix
            user = "${config.ethorbit.users.primary.username}";
        };

        devices.steamdeck = {
            enableXorgRotation = true;
        };
    };
}
