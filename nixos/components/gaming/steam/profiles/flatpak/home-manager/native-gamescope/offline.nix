{ config, lib, ... }:

with lib;

let
    cfg = config.ethorbit.components.gaming.steam.flatpak;
in
{
    config = lib.mkIf cfg.offline.enable (lib.mkIf cfg.gamescope.enable {
        environment.systemPackages = [
            cfg.gamescope.wrappers.offline
        ];

        home-manager.sharedModules = [ {
            xdg.desktopEntries."gamescope-steam-offline" = mkMerge [
                cfg.gamescope.desktop.defaultProps
                {
                    name = "Steam (Gamescope) (Offline)";
                    comment = "Application for managing and playing games on Steam without internet, inside Gamescope";
                    exec = "${cfg.gamescope.wrappers.offline}/bin/gamescope-steam-offline.sh";
                }
            ];
        } ];
    });
}
