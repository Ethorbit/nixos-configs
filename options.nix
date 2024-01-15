{ config, lib, ... }:

{
    options.ethorbit = with lib; {
        network = {
            router = {
                defaultGateway = mkOption {
                    type = types.str;
                    default = "192.168.254.254";
                };
            };
        };
    };
}
