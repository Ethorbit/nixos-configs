{ config, ... }:

{
    imports = [
        ./workspaces.nix
    ];

    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/i3" = {
            source = ./config;
            recursive = true;
        };
    };
}
