{ config, lib, inputs, system, ... }:

with lib;

let
    makeEntry = entry: {
        autoStart = false;
        additionalCapabilities = [ ];
        allowedDevices = [ ];
        bindMounts = { };
        ephemeral = false;
        extraFlags = [ ];
        imports = [ ];
    } // entry;
in
{
    imports = [
        (import ./entries { inherit config; inherit lib; inherit makeEntry; })
    ];

    options.ethorbit.workstation.containers = {
        entries = mkOption {
            type = types.attrs;
            default = { };
        };
    };

    config = {
        # Turn the container entries into actual containers.
        containers = mapAttrs (name: data: {
            inherit (data) autoStart additionalCapabilities ephemeral extraFlags;        

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

                boot.isContainer = mkForce true;
                boot.enableContainers = mkDefault false;

                # This is required if no root password or sudo user is available
                # Using root inside a container is dangerous for the host - avoid it.
                users.allowNoPasswordLogin = true;

                system.stateVersion = "23.11";

                # Add host as a host entry
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
                    ../host-and-containers
                ] ++ data.imports;
            };
        }) config.ethorbit.workstation.containers.entries;
    };
}
