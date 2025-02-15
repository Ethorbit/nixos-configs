{ config, ... }:

{
    # Rotate XFCE desktop
    home-manager.sharedModules = [ {
        xfconf.settings = {
            displays = {
                "Rotation" = 0;
                "Default/eDP-1/Rotation" = 270;
                "Default/eDP-1/Reflection" = "0";
            };
        };
    } ];
}
