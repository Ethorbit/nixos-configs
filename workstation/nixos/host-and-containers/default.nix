# Configuration shared by workstation host and all its containers
{ config, ... }:

{
    imports = [
        ./users.nix
        ./packages.nix
        ./networking.nix
        ./coturn.nix

        ../../../nixos/components/networking/systemd
        ../../../nixos/components/service-discovery/profiles/avahi

        ../../../nixos/components/audio-server/profiles/pulseaudio

        # Identical graphics config needed so that containers can ALSO use the GPU
        # no need to shell out money for NVIDIA's vGPU technology :D
        ../../../nixos/components/graphics-drivers/opengl
        ../../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
        ../../../nixos/components/graphics-drivers/nvidia/profiles/cuda
    ];

    ethorbit.graphics.nvidia.proprietary.selectedPackage = config.boot.kernelPackages.nvidiaPackages.production;
}
