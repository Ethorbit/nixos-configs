{ config, lib, ... }:

{
    config = lib.mkIf (config.networking.firewall.enable == true) {
        networking.firewall.allowedUDPPorts = [ 5353 ];
    };
}
