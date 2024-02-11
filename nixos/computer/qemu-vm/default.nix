{ config, ... }:

{
    imports = [
        ./monitors.nix
        ../../components/qemu-guest
        ../../components/spice-guest
    ];
}
