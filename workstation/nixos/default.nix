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
        ../../nixos/components/programming/ide
        ../../nixos/components/graphics-drivers/opengl
        ../../nixos/components/graphics-drivers/nvidia/profiles/cuda
        ../../nixos/components/input-streaming/usbip
    ];
}
