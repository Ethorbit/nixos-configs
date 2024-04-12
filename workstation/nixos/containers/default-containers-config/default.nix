{ config, ... }:

{
    imports = [
        ./networking.nix
        ./packages.nix
        ../../host-and-containers
        ./desktop.nix
    ];

    boot.isContainer = true;

    # realtime audio
    security.rtkit.enable = true;

    # This is required if no root password or sudo user is available
    # Using root inside a container is dangerous for the host - avoid it.
    users.allowNoPasswordLogin = true;
    users.groups."video" = {};

    system.stateVersion = "23.11";
}
