{ config, ... }:

let
    shellVars = ''
        EDITOR=nvim
        VISUAL=nvim
    '';
in
{
    imports = [
        ./plugins.nix
        ./options.nix
    ];

    home-manager.users.${config.ethorbit.users.primary.username} = {
        programs.neovim = {
            enable = true;
            defaultEditor = true;
            vimAlias = true;
            viAlias = true;
            vimdiffAlias = true;
        };

        home.file.".config/nvim" = {
            source = ./config;
            recursive = true;
        };

        home.file.".config/nvim/lua/nix.lua".text = ''
            vim.g.godot_executable = "${config.ethorbit.home-manager.nvim.godotPath}"
        '';

        programs.bash.bashrcExtra = shellVars;
        programs.zsh.initExtra = shellVars;
    };
}
