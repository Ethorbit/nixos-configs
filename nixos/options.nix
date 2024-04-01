{ config, lib, ... }:

{
    options.ethorbit = with lib; {
        users = {
            primary = {
                username = mkOption {
                    type = types.str;
                    default = "ethorbit";
                };
            };
        };

        network = {
            router = {
                defaultGateway = mkOption {
                    type = types.str;
                    default = "192.168.254.254";
                };
				
				LAN.CIDR = mkOption {
					type = types.str;
					default = "192.168.254.1/24";
				};
            };

			# This would be like the static IP of a Central Administration or Hypervisor device
			# If you do not have or use one, just match it with LAN.CIDR; the purpose for this is
			# some systems want to ensure visibility is only between them, the manager and no one else.
			admin.ip = "192.168.254.220";

            homenas = {
                ip = mkOption {
                    type = types.str;
                    default = "192.168.254.221";
                };
            };
        };

        system = {
            profile.name = mkOption {
                type = types.str;
                default = "default";
            };

            # This is blank for no container or
            # the string of the type of container
            container = mkOption {
                type = types.str;
                default = "";
            };
        };
    };
}
