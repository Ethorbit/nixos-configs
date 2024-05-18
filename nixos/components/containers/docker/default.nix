{ config, pkgs, lib, ... }:

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
            enableNvidia = with lib; mkIf (config.hardware.nvidia.package != types.unspecified) true;
        };

        oci-containers = {
            backend = "docker";
        };
    };

    users.users."${config.ethorbit.users.primary.username}" = {
        extraGroups = [ "docker" ];
    };
}
