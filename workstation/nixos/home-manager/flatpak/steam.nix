{ config, ... }:

let
    id = "${config.ethorbit.components.gaming.steam.flatpak.appName}";
in
{
    ethorbit.components.gaming.steam.flatpak = {
        offline.enable = true;
        gamescope.enable = true;
    };

    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            overrides = {
                "${id}" = {
                    "Context" = {
                        filesystems = config.ethorbit.workstation.home-manager.flatpak.overrides.games.filesystems;
                    };
                    
                    # Steam has shown that it misbehaves itself when given control over the screen saver
                    # It permanently keeps the system active and it never locks because of it..
                    "Session Bus Policy" = {
                        "org.freedesktop.ScreenSaver" = "none";
                        "org.freedesktop.PowerManagement" = "none";
                    };
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
