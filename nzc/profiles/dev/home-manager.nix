{ homeModules, ... }:

{
    home-manager.sharedModules = 
     with homeModules; [
        wallpapers
    ] ++ [ {
        ethorbit.home-manager.wallpapers = [
            "zombies_at_phoneburnia"
        ];

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
