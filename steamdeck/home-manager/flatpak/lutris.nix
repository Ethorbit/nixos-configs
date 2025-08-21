{ config, ... }:

let
    id = "${config.ethorbit.components.gaming.lutris.flatpak.appName}";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            overrides = {
                "${id}".Context = {
                    filesystems = config.ethorbit.workstation.home-manager.flatpak.overrides.games.filesystems;
                };
            };
        };
    };
}
