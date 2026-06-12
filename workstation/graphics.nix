{ config, ... }:

{
    imports = [
        ../nixos/components/graphics-drivers/opengl
        ../nixos/components/graphics-drivers/nvidia/profiles/proprietary
        ../nixos/components/graphics-drivers/nvidia/profiles/cuda
    ];

    ethorbit.graphics.nvidia.proprietary = {
        # GTX 1060 is no longer supported
        selectedPackage = config.boot.kernelPackages.nvidiaPackages.legacy_580;
        powerLimit = {
            enable = true;
            limit = 60;
        };
    };
}
