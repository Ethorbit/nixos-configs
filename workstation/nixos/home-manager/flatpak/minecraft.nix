{ config, ... }:

let
    id = "${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            overrides = {
                "${id}".Context = {
                    filesystems = [ "/mnt/games/PrismLauncher" ];
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
