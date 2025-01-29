{ config, pkgs, ... }:

{
    imports = [
        ./native-gamescope.nix
    ];

    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.moonlight.flatpak.appName}";
                    origin = "flathub";
                }
            ];
        };
    } ];
}
