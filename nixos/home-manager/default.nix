{ config, ... }:

{
    imports = [
        ./bash
        ./dconf
        ./gtk
        ./qt
    ];

    home-manager = {
        useGlobalPkgs = true;

        users.${config.ethorbit.users.primary.username} = {
            home.stateVersion = "23.11";
        };
    };
}
