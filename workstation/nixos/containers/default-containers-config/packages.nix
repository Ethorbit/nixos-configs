{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        #linuxKernel.packages.linux_6_1.nvidia_x11_production
        xorg.libXtst
        xorg.xeyes
    ];
}
