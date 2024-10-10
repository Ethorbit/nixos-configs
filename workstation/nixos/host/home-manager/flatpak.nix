{ config, ... }:

{
    home-manager.users.${config.ethorbit.users.primary.username} = {
        services.flatpak = {
            enable = true;
            packages = [
                {
                    appId = "com.valvesoftware.Steam";
                    origin = "flathub";
                }
                {
                    appId = "net.lutris.Lutris";
                    origin = "flathub";
                }
            ];
        };
    };
}
