{ config, ... }:

{
    networking = {
        hostName = "steamdeck";
        networkmanager.enable = true;
    };
}
