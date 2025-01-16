{ config, lib, ... }:

with lib;

let
    cfg = config.ethorbit.components.gaming.steam.flatpak;
in
{
    config = lib.mkIf cfg.gamescope.enable (lib.mkIf cfg.gamescope.mangohud.enable {
        environment.systemPackages = with cfg.gamescope.wrappers; [
            mangohud
            mangohud-offline
        ];

        home-manager.sharedModules = [ {
            xdg.desktopEntries."gamescope-steam-mangohud" = mkMerge [
                cfg.gamescope.desktop.defaultProps
                {
                    name = "Steam (Gamescope + MangoHUD)";
                    comment = "Application for managing and playing games on Steam, inside Gamescope";
                    exec = "${cfg.gamescope.wrappers.mangohud}/bin/gamescope-steam-mangohud.sh";
                }
            ];

            xdg.desktopEntries."gamescope-steam-offline-mangohud" = mkMerge [
                cfg.gamescope.desktop.defaultProps
                {
                    name = "Steam (Gamescope + MangoHUD) (Offline)";
                    comment = "Application for managing and playing games on Steam without internet, inside Gamescope";
                    exec = "${cfg.gamescope.wrappers.mangohud-offline}/bin/gamescope-steam-mangohud-offline.sh";
                }
            ];
        } ];
    });
}
