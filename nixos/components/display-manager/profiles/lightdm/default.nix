{ config, ... }:

{
    services.xserver.displayManager.lightdm = {
        enable = true;
        greeters.gtk.enable = true;
    };
}
