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
        #../nixos/components/desktop-streaming/profiles/sunshine
    ];

    buildMachines = [ {
        hostName = "192.168.254.186";
        sshUser = "builder";
        system = "x86_64-linux";
        sshKey = config.age.secrets."build-machines/primary/sshkey".path;
    } ];

    jovian = {
        steamos.useSteamOSConfig = true;

        steam = {
            enable = true;
            autoStart = true;
            desktopSession = "xfce";
            user = "${config.ethorbit.users.primary.username}";
        };

        devices.steamdeck = {
            enable = true;
            enableXorgRotation = true;
        };
    };
}
