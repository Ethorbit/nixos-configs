{ config, ... }:

{
    imports = [
        ../../components/guest/profiles/qemu
        ../../components/guest/profiles/spice
        ../../components/video-driver/profiles/qxl
    ];
}
