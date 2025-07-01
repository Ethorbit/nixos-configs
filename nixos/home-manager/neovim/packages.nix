{ pkgs, ... }:

{
    home-manager.sharedModules = with pkgs; [ {
        programs.neovim.extraPackages = [
            ranger
            ripgrep
        ];
    } ];
}
