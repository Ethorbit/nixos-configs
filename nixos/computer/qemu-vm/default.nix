{ config, ... }:

{
    imports = [
        ./services.nix
        ../../components/qemu-guest
        ../../components/spice-guest
    ];
}
