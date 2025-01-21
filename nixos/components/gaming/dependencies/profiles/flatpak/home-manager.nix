{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.gamescope23}";
                    # 23.08 commit when locked to 3.14.24 before they broke everything (which they're very good at doing!)
                    commit = "6815075a1012258cdabe0d79171b7ee19b310f7b1a68fcbd62218da42eaae054";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.gamescope24}";
                    # Initial commit of 24.08 before they broke everything (which they're very good at doing!)
                    commit = "b3ce5ac9ce3ae0cbe4b701a8d32959185c5e995472a6bd6bdee73b9b8e92eb08";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.mangohud}";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.proton}";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.protonup-qt}";
                    origin = "flathub";
                }
                # By default, Protontricks only has access to the Steam installation directory.
                # You will need to add filesystem permissions for additional Steam library locations, 
                # and other directories when running external EXEs.
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.protontricks}";
                    origin = "flathub";
                }
            ];
        };
    } ];
}
