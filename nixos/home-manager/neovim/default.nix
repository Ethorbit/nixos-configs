{ config, ... }:

let
    shellVars = ''
        EDITOR=nvim
        VISUAL=nvim
        NVIM_GODOT_PATH="${config.ethorbit.home-manager.nvim.godotPath}"
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

        programs.bash.bashrcExtra = shellVars;
        programs.zsh.initExtra = shellVars;
    };
}
