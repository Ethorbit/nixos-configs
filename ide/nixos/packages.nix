{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        kitty
        zsh
        git
    ];

    programs.zsh.enable = true;
}
