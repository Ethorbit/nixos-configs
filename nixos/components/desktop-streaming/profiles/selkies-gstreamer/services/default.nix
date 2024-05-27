{ config, lib, pkgs, ... }:

{
    imports = [
        ./selkies-gstreamer.nix
        ./virtual-xserver.nix
    ];

    services.xserver.displayManager = with lib; {
        # Selkies-Gstreamer will manage its own Virtual X server.
        # The issue is that display managers want to run THEIR own (non-virtual) X server,
        # so you cannot use this component and a display manager at the same time.
        startx.enable = mkForce true;
        lightdm.enable = mkForce false;
        sddm.enable = mkForce false;

        # Set this instead to start your desired desktop experience.
        #sessionCommands = ''commands here'';
    };
}
