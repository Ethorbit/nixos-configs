{ config, lib, pkgs, ... }:

with lib;
with pkgs;
{
    xdg.portal = {
        enable = mkDefault true;
        extraPortals = mkDefault [
            xdg-desktop-portal-gtk
        ];
        config.common.default = mkDefault [ "gtk" ];
    };
}
