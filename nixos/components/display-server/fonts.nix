{ config, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        siji
    ];
}
