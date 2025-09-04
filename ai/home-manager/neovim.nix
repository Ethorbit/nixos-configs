# Settings to help edit over SSH

{ ... }:

{
    home-manager.sharedModules = [ {
        home.file.".config/nvim/lua/custom/init.lua".text = ''
            vim.g.clipboard = "osc52"
        '';
    } ];
}
