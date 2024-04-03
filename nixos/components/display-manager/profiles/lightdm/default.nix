{ config, lib, ... }:

{
    services.xserver.displayManager.lightdm = {
        enable = lib.mkDefault true;
        greeters.gtk.enable = lib.mkDefault true;
    };
}
