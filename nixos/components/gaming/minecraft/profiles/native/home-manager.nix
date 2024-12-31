{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        xdg.desktopEntries."prism-launcher-gamescope" = {
            name = "Prism Launcher (Gamescope)";
            comment = "Prism Launcher, but contained inside Gamescope";
            exec = "${pkgs.gamescope}/bin/gamescope -w 1920 -h 1080 -W 1920 -H 1080 -f --immediate-flips --force-grab-cursor -- ${pkgs.prismlauncher}/bin/prismlauncher";
            terminal = false;
            type = "Application";
            categories = [ "Game" ];
        };
    } ];
}
