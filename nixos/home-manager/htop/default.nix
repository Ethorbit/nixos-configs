{ config, lib, pkgs, ... }:

{
    programs.bash.shellAliases = {
        top = "htop";
    };

    programs.zsh.shellAliases = {
        top = "htop";
    };

    programs.htop = {
        enable = lib.mkDefault true;
        package = pkgs.htop-vim;
    };
}
