# Configuration shared by workstation host and all its containers
{ config, ... }:

{
    # Identical graphics config needed so that containers can ALSO use the GPU
    # no need to shell out money for NVIDIA's vGPU technology :D
    imports = [
        ./users.nix
        ./networking.nix
        ../../../nixos/components/graphics-drivers/opengl
        ../../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
    ];
}
