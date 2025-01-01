{ config, pkgs, lib, ... }:

with lib;

{
    home-manager.sharedModules = [ {
        xdg.desktopEntries."prism-launcher-gamescope" = {
            name = "Prism Launcher (Gamescope)";
            comment = "Prism Launcher, but contained inside Gamescope";
            exec = lib.mkDefault "${pkgs.gamescope}/bin/gamescope ${escapeShellArgs config.ethorbit.components.gaming.minecraft.launcher.gamescope.flags} ${pkgs.gamemode}/bin/gamemoderun -- ${pkgs.prismlauncher}/bin/prismlauncher";
            terminal = false;
            type = "Application";
            categories = [ "Game" ];
        };
    } ];
}
