{ config, ... }:

{
    imports = [
        ../nixos/components/graphics-drivers/opengl
        ../nixos/components/graphics-drivers/nvidia/profiles/proprietary
        ../nixos/components/graphics-drivers/nvidia/profiles/cuda
    ];

    ethorbit.graphics.nvidia.proprietary = {
        selectedPackage = config.boot.kernelPackages.nvidiaPackages.stable;
        powerLimit = {
            enable = true;
            limit = 100;
        };
    };
}
