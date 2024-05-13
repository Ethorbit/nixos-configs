{ config, pkgs, ... }:

{
    fonts.packages = with pkgs; [
        noto-fonts
        noto-fonts-cjk
        noto-fonts-emoji
        fantasque-sans-mono
        siji
        fira-code
        fira-code-nerdfont
    ];
}
