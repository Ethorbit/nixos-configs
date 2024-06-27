{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        xorg.libxcvt
        xclip
        xsel
        libGL
        virtualgl
    ];
}
