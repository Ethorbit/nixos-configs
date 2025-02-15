{ config, pkgs, lib, ... }:

{
    virtualisation = {
        podman = {
            enable = true;
            enableNvidia = with lib; mkIf (config.hardware.nvidia.package != types.unspecified) true;
        };

        oci-containers = {
            backend = "podman";
        };
    };
}
