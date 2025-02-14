{ config, ... }:

{
    networking = {
        hostName = "steamdeck";
        interfaces.wlan0 = {};
        defaultGateway.interface = "wlan0";
        networkmanager.enable = true;
    };
}
