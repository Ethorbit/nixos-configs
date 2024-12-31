{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
                    origin = "flathub";
                }
            ];
        };

        xdg.desktopEntries."prism-launcher-gamescope" = {
            name = "Prism Launcher (Gamescope)";
            comment = "Prism Launcher, but contained inside Gamescope";
            exec = "${pkgs.gamescope}/bin/gamescope -w 1920 -h 1080 -W 1920 -H 1080 -f --immediate-flips --force-grab-cursor -- flatpak run ${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
            icon = "${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
            terminal = false;
            type = "Application";
            categories = [ "Game" ];
        };
    } ];
}
