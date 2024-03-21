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
            };

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
