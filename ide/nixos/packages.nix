{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        ranger
        trash-cli
        zsh
        git-lfs
    ];
    
    programs.zsh.enable = true;
}
