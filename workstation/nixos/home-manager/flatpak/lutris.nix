{ config, ... }:

let
    id = "${config.ethorbit.components.gaming.lutris.flatpak.appName}";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/systemd/user/app-flatpak-${id}-.scope.d/slice.conf".text = ''
            [Scope]
            Slice=gaming.slice
        '';
    };
}
