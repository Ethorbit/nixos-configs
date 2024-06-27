{ config, lib, ... }:

with lib;
{
    options.ethorbit.workstation = {
        network = {
            host.ip = mkOption {
                type = types.str;
                default = "172.16.1.210";
            };
        };
    };
}
