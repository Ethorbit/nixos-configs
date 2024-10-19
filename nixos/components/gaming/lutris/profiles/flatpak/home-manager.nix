# Your user must turn on Flatpak for this to work.

{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.lutris.flatpak.appName}";
                    origin = "flathub";
                }
            ];
        };
    } ];
}
