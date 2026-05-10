{ config, pkgs, lib, ... }:

with lib;

let
    hasNvidia = config.hardware.nvidia.enabled;
in
{
    imports = [
        ../.
    ];

    environment.systemPackages = with pkgs; [
        dive
    ];

    virtualisation = {
        docker = {
            enable = true;
            enableOnBoot = true;

            # trace: warning: You have set virtualisation.docker.enableNvidia. This option is deprecated, please set hardware.nvidia-container-toolkit.enable instead.
            # ^ yeah so nvidia-container-toolkit DOES NOT work if the "new" option is used, so I'm still using this until things change..
            enableNvidia = hasNvidia;
        };

        oci-containers = {
            backend = "docker";
        };
    };

    # NVIDIA container toolkit
    hardware.nvidia-container-toolkit.enable = hasNvidia;
    # FIX: always suppress assertion if NVIDIA drivers might not exist
    hardware.nvidia-container-toolkit.suppressNvidiaDriverAssertion = true;

    users.users."${config.ethorbit.users.primary.username}" = {
        extraGroups = [ "docker" ];
    };
}
