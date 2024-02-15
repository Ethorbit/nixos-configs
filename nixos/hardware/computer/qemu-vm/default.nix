{ config, ... }:

{
    imports = [
        ./services.nix
        ../../../components/guest/profiles/qemu
        ../../../components/guest/profiles/spice
        ../../../components/video-driver/profiles/qxl
    ];
}
