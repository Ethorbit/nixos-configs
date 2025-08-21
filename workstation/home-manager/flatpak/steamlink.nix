{ config, ... }:

let
    id = "com.valvesoftware.SteamLink";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            packages = [ { appId = "${id}"; origin = "flathub"; } ];
        };

        home.file.".config/systemd/user/app-flatpak-${id}-.scope.d/slice.conf".text = ''
            [Scope]
            Slice=gaming.slice
        '';
    };
}
