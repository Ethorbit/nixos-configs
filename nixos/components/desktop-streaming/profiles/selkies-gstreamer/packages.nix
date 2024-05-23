{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; with xorg; [
        libGL
        mesa
        virtualgl
        libglvnd
        libGLU
        
        # xorg stuff
        libXau
        libXdmcp
        libxcb
        libXext
        libX11
        libXv
        libXtst
        libSM
    ];
}
