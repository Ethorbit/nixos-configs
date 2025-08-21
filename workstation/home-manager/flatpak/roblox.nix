{ config, lib, ... }:

with lib;

let
    cfg = config.ethorbit.components.gaming.roblox.flatpak;

    keys = [
        cfg.game
        cfg.studio
    ];
in
{
    # Sober doesn't work with gamescope \o/
    #ethorbit.components.gaming.roblox.flatpak.gamescope.enable = true;

    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            overrides = listToAttrs (map (val: {
                name = "${val.appName}";
                value = {
                    Context = {
                        filesystems = [
                            "/mnt/games/Roblox"
                            "/mnt/games/Roblox-Studio"
                        ];
                    };
                };
            }) keys);
        };

        home.file = listToAttrs (map (val: {
            name = ".config/systemd/user/app-flatpak-${val.appName}-.scope.d/slice.conf";
            value = {
                text = ''
                    [Scope]
                    Slice=gaming.slice
               '';
            };
        }) keys);
    };
}
