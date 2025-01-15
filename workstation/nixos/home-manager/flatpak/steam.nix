{ config, ... }:

let
    id = "${config.ethorbit.components.gaming.steam.flatpak.appName}";
in
{
    ethorbit.components.gaming.steam.flatpak.gamescope.enable = true;

    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            overrides = {
                "${id}".Context = {
                    filesystems = config.ethorbit.workstation.home-manager.flatpak.overrides.games.filesystems;
                };
            };
        };

        home.file = {
            ".config/systemd/user/app-flatpak-${id}-.scope.d/slice.conf".text = ''
                [Scope]
                Slice=gaming.slice
            '';
        };
    };
}
