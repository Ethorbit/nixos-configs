{
    home-manager.sharedModules = [ {
        home.file.".config/nvim/lua/custom/setup/codecompanion.lua".source = ./codecompanion-setup.lua;
    } ];
}
