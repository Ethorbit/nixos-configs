{ ... }:

{
    home-manager.sharedModules = [ {
        home.file.".config/nvim/lua/custom/init.lua".source = ./init.lua;
    } ];
}
