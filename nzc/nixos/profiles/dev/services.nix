{ config, ... }:

{
    services.resolved.enable = false;
    
    services.dnsmasq = {
        enable = true;
        
        settings = {
            server = [ "${config.ethorbit.network.router.defaultGateway}" ];
            address = "/nzc.local/127.0.0.1";
        };
        
        #extraConfig = ''
        #    address=/nzc.local/127.0.0.1
        #'';
    };
}
