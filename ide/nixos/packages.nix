{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        kitty
        zsh
        neovim
        git
    ];

    programs.zsh.enable = true;
}
