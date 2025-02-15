{ config, ... }:

{
    imports = [
        ../../nixos/components/gaming/lutris/profiles/flatpak
        ../../nixos/components/gaming/minecraft/profiles/flatpak
    ];

    services.flatpak = {
        enable = true;
        uninstallUnmanaged = false;
        packages = [];
    };
}
