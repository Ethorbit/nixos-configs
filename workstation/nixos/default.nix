{ config, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./bootloader.nix
        ./users.nix
        ./packages.nix
        ./udev.nix
        ./services.nix
        ./docker
        ./networking
        ../../nixos/components/programming/ide
        ../../nixos/components/graphics-drivers/opengl
        ../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
        ../../nixos/components/input-streaming/usbip
    ];
}
