{ config, ... }:

{
    imports = [
        ./nvidia-egl-desktop
    ];

    virtualisation = {
        docker = {
            enable = true;
            enableOnBoot = true;
            enableNvidia = true;
        };

        oci-containers = {
            backend = "docker";
        };
    };
}
