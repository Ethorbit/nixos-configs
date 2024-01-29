{ config, pkgs, ... }:

{
    # TODO: install these plugins manually:
    # vim-tabby
    # confirm-quit
    home-manager.users.ide.programs.neovim.plugins = with pkgs.vimPlugins; [
        vim-rooter
        lualine-nvim
        nvim-web-devicons
        ranger-vim
        bclose-vim

        luasnip
        cmp-nvim-lsp
        cmp-buffer
        cmp-path
        cmp-cmdline
        nvim-cmp
        mason-nvim
        mason-lspconfig-nvim
 
        # LSP stuff
        nvim-lspconfig
        nvim-lint
        formatter-nvim
      
        vim-qml

        indent-blankline-nvim
        
        plenary-nvim
        telescope-nvim
        nvim-neoclip-lua
        
        nui-nvim
    ];
}
