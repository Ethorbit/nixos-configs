{ config, lib, ... }:

{
    config = lib.mkIf (config.networking.firewall.enable == true) {
        networking.firewall = {
            extraCommands = ''
                iptables -N SUNSHINE
                iptables -A SUNSHINE -p udp -m multiport --dports 47998,47999,48000,48002 -j ACCEPT
                iptables -A SUNSHINE -p tcp -m multiport --dports 47984,47989,47990,48010 -j ACCEPT
                iptables -A INPUT -j SUNSHINE
            '';
            
            extraStopCommands = ''
                iptables -D SUNSHINE
            '';
        };
    };
}
