{ config, lib, inputs, system, ... }:

with lib;

let
    # TODO: turn this function into a submodule function so that it can be referenced straight in the config without needing to include it with imports.
    # Maybe instead: restructure entries to be an attrsOf submodule { preferred structure here }, this would be harder as it would require changing everything that references entries
    # but in the end it would make entries easier to configure as no function would need to be called at all.
    makeEntry = entry: {
        autoStart = false;
        additionalCapabilities = [ ];
        allowedDevices = [ ];
        bindMounts = { };
        tmpfs = [ ];
        ephemeral = false;
        extraFlags = [ ];
        imports = [ ];
        resticRules = { };
        traefikCreator = name: data: {};
        # TODO: make autheliaCreator so that containers can easily specify their own authentication settings for their own Traefik pages.
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
            inherit (data) autoStart additionalCapabilities ephemeral tmpfs;        

            privateNetwork = true;
            localAddress = null;
            hostBridge = "br0";

            extraFlags = [
                "--tmpfs=/tmp:nosuid,size=16G"
            ] ++ data.extraFlags;

            bindMounts = mkMerge ((map (identityPath: {
                # Needed so that the containers can read their own age secrets
                "${identityPath}".isReadOnly = true;
            }) config.age.identityPaths) ++ [{
                "/sys/module".isReadOnly = true;

                "/dev/shm" = {};
                "/dev/fuse" = {};
                "/dev/mapper/control" = {};
                "/dev/loop-control" = {};

                # GPU
                "/dev/vga_arbiter" = {};
                "/dev/dri" = {};
                "/dev/nvidia-modeset" = {};
                "/dev/nvidia-uvm" = {};
                "/dev/nvidia-uvm-tools" = {};
                "/dev/nvidiactl" = {};
                "/dev/nvidia0" = {};
                #"/dev/nvidia-caps" = {};
                "/dev/nvram" = {};
            }] ++ [ data.bindMounts ]);

            allowedDevices = [
                {
                    modifier = "rwm";
                    node = "block-loop";
                }
                {
                    modifier = "rwm";
                    node = "block-blkext";
                }
                {
                    modifier = "rwm";
                    node = "block-device-mapper";
                }
                {
                    modifier = "rwm";
                    node = "/dev/loop-control";
                }
                {
                    modifier = "rwm";
                    node = "/dev/mapper/control";
                }
                {
                    modifier = "rwm";
                    node = "/dev/fuse";
                }

                # GPU
                {
                    modifier = "rw";
                    node = "/dev/dri";
                }
                {
                    modifier = "rw";
                    node = "/dev/dri/renderD128";
                }
                {
                    modifier = "rw";
                    node = "/dev/dri/card0";
                }
                {
                    modifier = "rw";
                    node = "char-drm";
                }
                {
                    modifier = "rw";
                    node = "char-nvidia-frontend";
                }
                {
                    modifier = "rw";
                    node = "char-nvidia-uvm";
                }
                {
                    modifier = "rw";
                    node = "/dev/nvidia-modeset";
                }
                {
                    modifier = "rw";
                    node = "/dev/nvidia-uvm";
                }
                {
                    modifier = "rw";
                    node = "/dev/nvidia-uvm-tools";
                }
                {
                    modifier = "rw";
                    node = "/dev/nvidiactl";
                }
                {
                    modifier = "rw";
                    node = "/dev/nvidia0";
                }
                #{
                #    modifier = "rw";
                #    node = "/dev/nvidia-caps";
                #}
            ] ++ data.allowedDevices;

            config = { config, ... }: {
                ethorbit.users.primary.username = name;
                ethorbit.home-manager.shell.prompt.symbol = "📦";
                ethorbit.home-manager.zsh.prompt.colors.prompt = "%F{yellow}";

                boot.isContainer = mkForce true;
                boot.enableContainers = mkDefault false;

                # This is required if no root password or sudo user is available
                # Using root inside a container is dangerous for the host - avoid it.
                users.allowNoPasswordLogin = true;

                system.stateVersion = "23.11";

                # Add host as a host entry
                networking.hosts."${config.ethorbit.workstation.network.host.ip}" = [ "host" ];

                # Setup network connectivity
                systemd.network.networks."20-eth" = {
                    matchConfig.Name = "eth*";
                    address = [ "${data.ip}/24" ];
                    dns = [ config.networking.defaultGateway.address ];
                    gateway = [ config.networking.defaultGateway.address ];
                };

                # Block IPv6 requests
                networking.firewall.extraCommands = ''
                    ip6tables -P INPUT DROP
                    ip6tables -P OUTPUT DROP
                    ip6tables -P FORWARD DROP
                '';

                # Load base nix config and all the container's configs
                imports = [
                    (import ../../../nixosmodules.nix { inherit inputs; inherit system; })
                    ../host-and-containers
                ] ++ data.imports;
            };
        }) config.ethorbit.workstation.containers.entries;
    };
}
