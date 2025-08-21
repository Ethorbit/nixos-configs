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
                    "Environment" = {
                        "OBS_VKCAPTURE" = "1";
                    };

                    "Context" = {
                        filesystems = config.ethorbit.workstation.home-manager.flatpak.overrides.games.filesystems;

                        # It can still do inter-process communication with its own container processes.
                        # There's really no need for it to need this for my use case
                        shared = "!ipc";
                    };
                    
                    # Steam has shown that it misbehaves itself when given control over these
                    # It permanently keeps the system active and it never locks because of it..
                    "Session Bus Policy" = {
                        "org.freedesktop.ScreenSaver" = "none";
                        "org.freedesktop.PowerManagement" = "none";
                        "org.gnome.SettingsDaemon.MediaKeys" = "none";
                        "org.freedesktop.Notifications" = "none";
                        "org.kde.StatusNotifierWatcher" = "none";
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
