{ config, lib, inputs, system, ... }:

with lib;
let
    entry = {
        autoStart = false;
        additionalCapabilities = [ ];
        allowedDevices = [ ];
        bindMounts = { };
        extraFlags = [ ];
        imports = [ ];
    };
in
{
    options.ethorbit.workstation.containers = mkOption {
        type = types.attrs;
        default = {
            "development" = entry // {
                ip = "172.12.1.220";
                imports = [ ./selkies-gstreamer ./development ];
                # To allow Docker to work
                extraFlags = [
                    "--system-call-filter=add_key"
                    "--system-call-filter=keyctl"
                    "--system-call-filter=bpf"
                ];
            };
        };
    };

    config = {
        containers = mapAttrs (name: data: {
            inherit (data) autoStart additionalCapabilities extraFlags;        

            ephemeral = false;

            privateNetwork = true;
            localAddress = null;
            hostBridge = "br0";

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
            }] ++ [ data.bindMounts ]);

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
            ] ++ data.allowedDevices;

            config = { config, ... }: {
                ethorbit.users.primary.username = name;

                networking.hosts."172.12.1.210" = [ "host" ];

                # Setup network connectivity
                systemd.network.networks."20-eth" = {
                    matchConfig.Name = "eth*";
                    address = [ "${data.ip}/24" ];
                    dns = [ config.networking.defaultGateway.address ];
                    gateway = [ config.networking.defaultGateway.address ];
                };

                # Load base nix config and all the container's configs
                imports = [
                    (import ../../../nixosmodules.nix { inherit inputs; inherit system; })
                ] ++ data.imports;
            };
        }) config.ethorbit.workstation.containers;
    };
}
