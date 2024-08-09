{ config, ... }:

{
    imports = [
        ./services.nix
        ../../../components/guest/profiles/qemu
        ../../../components/guest/profiles/spice
        ../../../components/graphics-drivers/qxl
    ];
}
