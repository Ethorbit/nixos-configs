{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; with gst_all_1; with xorg; [
        libGL
        mesa
        mesa-demos
        virtualgl
        libglvnd
        libGLU
        libva
        libva-utils
        libvncserver
        x11vnc
        vaapiVdpau
        vdpauinfo
        clinfo
        #dbus
        #xdg-utils
        #xdg-user-dirs
        #xsettingsd

        # gst_all_1
        gstreamer
        gst-vaapi
        gst-plugins-base

        # xorg
        #xinit
        #xauth
        #xbitmaps
        #xkbutils
        #xf86inputvoid
        #xf86inputmouse
        #xf86inputevdev
        #xf86inputvmmouse
        #xf86inputlibinput
        #xf86inputkeyboard
        #xf86inputjoystick
        #xf86inputsynaptics
        #xf86videonv
        #xf86videoati
        #xf86videovesa
        #xf86videor128
        #xf86videoi740
        #xf86videoi128
        #xf86videointel
        #xf86videofbdev
        #xf86videodummy
        #xf86videoamdgpu
        #xf86videonouveau
        libXau
        libXdmcp
        libxcb
        libXext
        libX11
        libXv
        libXtst
        libSM
        libXrandr
        libXdamage
        libXinerama
    ];
}
