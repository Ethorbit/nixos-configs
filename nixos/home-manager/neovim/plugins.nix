{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        programs.neovim = {
            withNodeJs = true;
            plugins = with pkgs.vimPlugins; [
                config.ethorbit.pkgs.vimPlugins.confirm-quit
                #config.ethorbit.pkgs.vimPlugins.tabbyml

                transparent-nvim

                vim-rooter
                lualine-nvim
                nvim-web-devicons
                ranger-vim
                bclose-vim
                comment-nvim

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
                vim-godot
                vim-svelte

                indent-blankline-nvim
                
                plenary-nvim
                telescope-nvim
                nvim-neoclip-lua
                
                nui-nvim
            ];
        };
    } ];
}
