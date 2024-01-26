{ config, ... }:

{
    imports = [
        ./git
        ./zsh
        ./ranger
        ./neovim
    ];

    home-manager = {
        useGlobalPkgs = true;
        users.ide = {
            home.stateVersion = "23.11";
        };
    };
}
