{ config, pkgs, ... }:

{
    imports = [
        ../../../packages/vim
    ];

    environment.systemPackages = with pkgs; [
        ranger
        trash-cli
        git-lfs
        qt6.full
        python311Packages.grip
        vscode-langservers-extracted
        nodePackages.eslint
        nodePackages.vscode-json-languageserver-bin
        nodePackages.vscode-html-languageserver-bin
        nodePackages.typescript-language-server
        lua-language-server
        dockerfile-language-server-nodejs
        docker-compose-language-service
    ];
}
