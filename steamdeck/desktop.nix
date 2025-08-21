{ config, pkgs, ... }:

{
    imports = [
        ../nixos/components/display-server/profiles/xserver
        ../nixos/components/desktop-environment/profiles/xfce
    ];

    # Add 'startx' or else desktop mode won't work
    services.xserver.displayManager.startx.enable = true;
}
