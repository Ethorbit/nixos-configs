{ config, ... }:

{
    imports = [
        ../../../../nixos/home-manager/wallpapers/zombies_at_phoneburnia
    ];

    home-manager.users.${config.ethorbit.users.primary.username} = {
        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "text/html" = [ "firefox.desktop" ];
                "application/xhtml+xml" = [ "firefox.desktop" ];
                "x-scheme-handler/http" = [ "firefox.desktop" ];
                "x-scheme-handler/https" = [ "firefox.desktop" ];
            };
        };
    };
}
