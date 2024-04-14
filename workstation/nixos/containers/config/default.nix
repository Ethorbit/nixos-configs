{ config, ... }:

{
    imports = [
        ./users.nix
        ./networking.nix
        ./packages.nix
        ../../host-and-containers
        ./desktop.nix
    ];

    boot.isContainer = true;
    boot.enableContainers = false;

    environment.variables.DISPLAY = ":${builtins.toString config.ethorbit.workstation.xorg.sessionNumbers.${config.ethorbit.users.primary.username}}";

    # realtime audio
    #security.rtkit.enable = true;

    # This is required if no root password or sudo user is available
    # Using root inside a container is dangerous for the host - avoid it.
    users.allowNoPasswordLogin = true;

    system.stateVersion = "23.11";
}
