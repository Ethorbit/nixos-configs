{ config, lib, pkgs, ... }:

with lib;

{
    fonts.packages = with pkgs; [
        noto-fonts
        # error: 'noto-fonts-cjk' has been renamed to/replaced by 'noto-fonts-cjk-sans'
        (if (config.system.nixos.release < "24.11") then noto-fonts-cjk else noto-fonts-cjk-sans)
        noto-fonts-emoji
        fantasque-sans-mono
        siji
        fira-code
        fira-code-nerdfont
    ];
}
