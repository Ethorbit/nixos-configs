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
        ../../nixos/components/desktop-streaming/profiles/sunshine
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

        # sh: line 1: /build/source/frontend/node_modules/.bin/rollup: Permission denied
        # ELIFECYCLE  Command failed with exit code 126.
        # Problem with their derivation? Maybe, but I value my time so I'm moving on..
        #decky-loader = {
        #    enable = true;
        #};
    };
}
