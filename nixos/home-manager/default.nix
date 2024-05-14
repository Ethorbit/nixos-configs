{ config, ... }:

{
    imports = [
        ./bash
    ];

    home-manager = {
        useGlobalPkgs = true;

        users.${config.ethorbit.users.primary.username} = {
            home.stateVersion = "23.11";
        };
    };
}
