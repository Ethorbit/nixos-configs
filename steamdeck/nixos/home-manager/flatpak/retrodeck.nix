{ config, ... }:

let
    id = "net.retrodeck.retrodeck";
in
{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            packages = [
                {
                    appId = "${id}";
                    origin = "flathub";
                }
            ];
            overrides = {
                "${id}" = {
                    Context = {
                        filesystems = [ "/mnt/sdcard_games/RetroDECK" ];
                    };
                };
            };
        };
    };
}
