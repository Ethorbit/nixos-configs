{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.gamescope}";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.mangohud}";
                    origin = "flathub";
                }
                {
                    appId = "${config.ethorbit.components.gaming.dependencies.flatpak.appNames.proton}";
                    # Bump SDK to 23.08 (185907be). Downgrades 9.15 to 8.14,
                    # but also fixes stability issues with 23.08 gamescope
                    # crashing for games
                    commit = "26d25975ae67c5db7d0e5973ccc8a1ca6bd75af8aa2f6ee5d57fe7ae76ef317e";
                    origin = "flathub";
                }
            ];
        };
    } ];
}
