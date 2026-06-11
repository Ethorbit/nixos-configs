{ config, pkgs, lib, ... }:

let
    hasNvidia = config.hardware.nvidia.enabled;
in
{
    virtualisation = {
        podman = {
            enable = true;
            enableNvidia = hasNvidia;
        };

        oci-containers = {
            backend = "podman";
        };
    };
}
