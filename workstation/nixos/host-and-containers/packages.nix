{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        xorg.xf86inputvoid
        xorg.xf86inputevdev
        xorg.xf86inputlibinput
        xorg.xf86videodummy
    ];
}
