# Configuration shared by workstation host and all its containers
{ config, ... }:

{
    imports = [
        ./xorgSessionNumbers.nix
        ./users.nix
        ./networking.nix
        ./packages.nix

        # Identical graphics config needed so that containers can ALSO use the GPU
        # no need to shell out money for NVIDIA's vGPU technology :D
        #
        # Sadly we cannot use game streaming solutions like Sunshine 
        # because /dev/uinput, /dev/input, etc, controls ALL sessions
        # and since those are kernel modules, they cannot be different 
        # from host. We can still use tools like Xephyr to securely nest 
        # X displays and control them separately.
        ../../../nixos/components/graphics-drivers/opengl
        ../../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
    ];

    ethorbit.graphics.nvidia.proprietary.selectedPackage = config.boot.kernelPackages.nvidiaPackages.production;
}
