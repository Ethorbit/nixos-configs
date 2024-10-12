{ config, ... }:

let
    id = "io.github.loot.loot";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            packages = [ { appId = "${id}"; origin = "flathub"; } ];
            overrides = {
                "${id}".Context = {
                    filesystems = config.ethorbit.workstation.home-manager.flatpak.overrides.games.filesystems;
                };
            };
        };

        home.file.".config/systemd/user/app-flatpak-${id}-.scope.d/slice.conf".text = ''
            [Scope]
            Slice=gaming.slice
        '';
    };
}
