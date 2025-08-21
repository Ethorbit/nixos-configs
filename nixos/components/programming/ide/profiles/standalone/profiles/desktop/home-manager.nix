{ homeModules, ... }:

{
    home-manager.sharedModules = 
     with homeModules; [
            wallpapers
    ] ++ [ {
        ethorbit.home-manager.wallpapers = [ "space/4k_1" ];

        xdg.mimeApps = {
            enable = true;
            defaultApplications = {
                "text/html" = [ "firefox.desktop" ];
                "application/xhtml+xml" = [ "firefox.desktop" ];
                "x-scheme-handler/http" = [ "firefox.desktop" ];
                "x-scheme-handler/https" = [ "firefox.desktop" ];
            };
        };
    } ];
}
