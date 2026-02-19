{ ... }:

{
    networking.firewall = {
        enable = true;
        allowedTCPPorts = [ 4455 ]; # OBS websocket
    };
}
