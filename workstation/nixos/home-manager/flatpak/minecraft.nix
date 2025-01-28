{ config, ... }:

let
    id = "${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
in
{
    ethorbit.components.gaming.minecraft.launcher.flatpak.gamescope.enable = true;

    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            overrides = {
                "${id}" = {
                    Context = {
                        filesystems = [ "/mnt/games/PrismLauncher" ];

                        # It can still do inter-process communication with its own container processes.
                        # There's really no need for it to need this for my use case
                        shared = "!ipc";
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
