{ config, ... }:

{
    imports = [
        ./plugins.nix
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
    };
}
