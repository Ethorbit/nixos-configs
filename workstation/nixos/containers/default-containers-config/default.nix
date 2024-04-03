{ config, ... }:

{
    imports = [
        ../../host-and-containers
        
        # Sunshine will be used to stream the graphical acceleration
        # out of the container for a pleasant desktop experience
        #
        # This means we can do graphics-intensive tasks **INSIDE** containers.
        # Poggers. Fuck NVIDIA and their greedy vGPU licensing :)
        ../../../../nixos/components/desktop-streaming/profiles/sunshine
        
        ./desktop.nix
    ];

    # This is required if no root password or sudo user is available
    # Using root inside a container is dangerous for the host - avoid it.
    users.allowNoPasswordLogin = true;

    system.stateVersion = "23.11";
}
