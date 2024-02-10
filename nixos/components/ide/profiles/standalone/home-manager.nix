{ config, ... }:

{
    imports = [
        ../../../../home-manager/wallpapers/space/4k_1
    ];

    home-manager.users.${config.ethorbit.users.primary.username} = {
        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "text/html" = [ "firefox.desktop" ];
                "x-scheme-handler/http" = [ "firefox.desktop" ];
                "x-scheme-handler/https" = [ "firefox.desktop" ];
            };
        };
    };
}
