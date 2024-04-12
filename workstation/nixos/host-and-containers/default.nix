# Configuration shared by workstation host and all its containers
{ config, ... }:

{
    # Identical graphics config needed so that containers can ALSO use the GPU
    # no need to shell out money for NVIDIA's vGPU technology :D
    imports = [
        ./users.nix
        ./networking.nix
        ./packages.nix

        # Sunshine will be used to stream the graphical acceleration
        # out of the container for a pleasant desktop experience
        #
        # This means we can do graphics-intensive tasks **INSIDE** containers.
        # Poggers. Fuck NVIDIA and their greedy vGPU licensing :)
        #
        # The host needs it too simply because it requires some kernel modules
        # but it will not actually be used on the host.
        ../../../nixos/components/desktop-streaming/profiles/sunshine
        
        ../../../nixos/components/graphics-drivers/opengl
        ../../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
    
    ];

    ethorbit.graphics.nvidia.proprietary.selectedPackage = config.boot.kernelPackages.nvidiaPackages.production;
}
