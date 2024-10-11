{ config, ... }:

let
    id = "com.valvesoftware.Steam";
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
    };
}
