{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/components/display-server/profiles/xserver
        ../../nixos/components/desktop-environment/profiles/xfce
    ];

    # Add 'startx' or else desktop mode won't work
    services.xserver.displayManager.startx.enable = true;

    # Rotate desktop
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
