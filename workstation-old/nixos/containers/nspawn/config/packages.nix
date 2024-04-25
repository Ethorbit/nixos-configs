{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # This was for a Sunshine attempt
        ##linuxKernel.packages.linux_6_1.nvidia_x11_production
        #xorg.libXtst
        #xorg.xeyes

        # (following morrolinux's guide for GPU accelerated container)
        libGL
        mesa
        virtualgl
    ];
}
