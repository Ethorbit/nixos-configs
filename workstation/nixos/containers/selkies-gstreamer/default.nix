{ config, ... }:

{
    imports = [
        ../../host-and-containers
        ./users.nix
        ./networking.nix
        ./packages.nix
        ./desktop
    ];

    boot.isContainer = true;
    boot.enableContainers = false;

    # This is required if no root password or sudo user is available
    # Using root inside a container is dangerous for the host - avoid it.
    users.allowNoPasswordLogin = true;

    system.stateVersion = "23.11";
}
