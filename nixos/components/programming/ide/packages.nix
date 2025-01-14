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
        nodePackages.eslint
        # error: vscode-json-languageserver-bin has been removed since the upstream repository is archived; consider using vscode-langservers-extracted instead.
        #nodePackages.vscode-json-languageserver-bin
        #nodePackages.vscode-html-languageserver-bin
        vscode-langservers-extracted
        nodePackages.typescript-language-server
        unstable.nodePackages.svelte-language-server
        lua-language-server
        dockerfile-language-server-nodejs
        docker-compose-language-service
    ];
}
