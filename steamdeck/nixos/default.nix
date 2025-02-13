{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./networking.nix
        ./services.nix
        ./packages
        ./users.nix
        ../../nixos/components/desktop-environment/profiles/xfce
    ];

    jovian.steam = {
        enable = true;
        autoStart = true;
        desktopSession = "xfce";
        # see users.nix
        user = "${config.ethorbit.users.primary.username}";
    };
}
