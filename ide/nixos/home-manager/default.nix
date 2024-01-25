{ config, ... }:

{
    imports = [
        ./neovim
    ];

    home-manager = {
        useGlobalPkgs = true;
        users.ide = {
            home.stateVersion = "23.11";
        };
    };
}
