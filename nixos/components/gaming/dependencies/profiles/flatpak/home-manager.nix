{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.gamescope23}";
                    # 23.08 commit when locked to 3.14.24 before they broke everything (which they're very good at doing!)
                    #commit = "6815075a1012258cdabe0d79171b7ee19b310f7b1a68fcbd62218da42eaae054";
                    # 2025 update, seems stable
                    commit = "1379b5ba7dff5164a302c6f3c338b65c4b3810cb47b07818f5527cf8684bed6d";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.gamescope24}";
                    # Initial commit of 24.08 before they broke everything (which they're very good at doing!)
                    #commit = "b3ce5ac9ce3ae0cbe4b701a8d32959185c5e995472a6bd6bdee73b9b8e92eb08";
                    # 2025 update, seems stable
                    commit = "17e43683ae25c79ea78ab47e92aafaf8752dfd74037de8aba604435a3e98c2d8";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.mangohud23}";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.mangohud24}";
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
