{ config, pkgs, ... }:

{
    imports = [
        ../../../packages/vim
        ../../../packages/nvim
    ];

    environment.systemPackages = with pkgs; [
        ranger
        trash-cli
        git-lfs
        qt6.full
        python311Packages.grip
        (python3.withPackages (p: (with p; [
            python-lsp-server
            flake8
            pycodestyle
            pyflakes
            pylint
            pylsp-mypy
            pyls-isort
        ])))
        vscode-langservers-extracted
        nodePackages.eslint
        nodePackages.vscode-json-languageserver-bin
        nodePackages.vscode-html-languageserver-bin
        nodePackages.typescript-language-server
        unstable.nodePackages.svelte-language-server
        lua-language-server
        dockerfile-language-server-nodejs
        docker-compose-language-service
    ];
}
