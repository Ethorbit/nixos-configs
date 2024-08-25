{ config, pkgs, lib, ... }:

with lib;

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
            enableNvidia = with lib; mkIf (config.hardware.nvidia.package != types.unspecified) true;
        };

        oci-containers = {
            backend = "docker";
        };
    };

    hardware.nvidia-container-toolkit.enable = mkIf (config.hardware.nvidia.package != types.unspecified) true;

    users.users."${config.ethorbit.users.primary.username}" = {
        extraGroups = [ "docker" ];
    };
}
