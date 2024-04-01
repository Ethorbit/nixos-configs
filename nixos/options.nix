{ config, lib, ... }:

{
    options.ethorbit = with lib; {
        users = {
            primary = {
                username = mkOption {
                    type = types.str;
                    description = "The primary username of the system. This is mostly relevant for single-user systems.";
                    default = "ethorbit";
                };
            };
        };

        network = {
            router = {
                defaultGateway = mkOption {
                    type = types.str;
                    description = "The router's default gateway.";
                    default = "192.168.254.254";
                };
                
                LAN.CIDR = mkOption {
                    type = types.str;
                    description = "The CIDR range of the router's LAN.";
                    default = "192.168.254.1/24";
                };
            };

            # The static IP of the central administration device.
            # If you do not have or use one, just match it with LAN.CIDR.
            admin.ip = mkOption {
                type = types.str;
                description = "The IP or CIDR range of a trustworthy / central administration / hypervisor remote device(s). Most systems don't need this.";
                default = "192.168.254.220";
            };

            homenas = {
                ip = mkOption {
                    type = types.str;
                    description = "The static IP of the primary CIFS NAS that systems will use for their own networked storage.";
                    default = "192.168.254.221";
                };
            };
        };

        system = {
            profile.name = mkOption {
                type = types.str;
                description = "The selected system's profile name.";
                default = "default";
            };

            # This is blank for no container or
            # the string of the type of container
            # (Do not set it here.)
            container = mkOption {
                type = types.str;
                description = "Describes what type of container is in use. Empty string means no container is being used.";
                default = "";
            };
        };
    };
}
