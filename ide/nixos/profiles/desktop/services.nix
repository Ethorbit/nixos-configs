{ config, ... }:

{
    services = {
        xserver = {
            windowManager.i3.enable = true;
            displayManager.lightdm.enable = true;
        };
    };
}
