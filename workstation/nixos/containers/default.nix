{ config, lib, inputs, system, ... }:

with lib;

{
    options.ethorbit.workstation.containers = mkOption {
        type = types.attrs;
        default = {
            "development" = {
                ip = "172.12.1.220";
                imports = [ ./selkies-gstreamer ];
            };
        };
    };

    config = {
        containers = mapAttrs (name: data: {
            ephemeral = false;

            autoStart = false;

            privateNetwork = true;
            localAddress = null;

            hostBridge = "br0";

            additionalCapabilities = [ ];

            bindMounts = mkMerge ((map (identityPath: {
                # Needed so that the containers can read their own age secrets
                "${identityPath}".isReadOnly = true;
            }) config.age.identityPaths) ++ [{
                "/dev/shm" = {};
                "/dev/fuse" = {};
                "/sys/module".isReadOnly = true;

                # GPU
                "/dev/vga_arbiter" = {};
                "/dev/dri" = {};
                "/dev/nvidia-modeset" = {};
                "/dev/nvidia-uvm" = {};
                "/dev/nvidia-uvm-tools" = {};
                "/dev/nvidiactl" = {};
                "/dev/nvidia0" = {};
            }]);

            allowedDevices = [
                {
                    modifier = "rwm";
                    node = "/dev/fuse";
                }

                # GPU
                {
                    modifier = "rwm";
                    node = "char-drm";
                }
                {
                    modifier = "rwm";
                    node = "/dev/dri/renderD128";
                }
                {
                    modifier = "rwm";
                    node = "/dev/dri/card0";
                }
                {
                    modifier = "rwm";
                    node = "/dev/nvidia-modeset";
                }
                {
                    modifier = "rwm";
                    node = "/dev/nvidia-uvm";
                }
                {
                    modifier = "rwm";
                    node = "/dev/nvidia-uvm-tools";
                }
                {
                    modifier = "rwm";
                    node = "/dev/nvidiactl";
                }
                {
                    modifier = "rwm";
                    node = "/dev/nvidia0";
                }
            ];

            config = { config, ... }: {
                ethorbit.users.primary.username = name;

                systemd.network.networks."20-eth" = {
                    matchConfig.Name = "eth*";
                    address = [ "${data.ip}/24" ];
                };

                imports = [
                    (import ../../../nixosmodules.nix { inherit inputs; inherit system; })
                ] ++ data.imports;
            };
        }) config.ethorbit.workstation.containers;
    };
}
