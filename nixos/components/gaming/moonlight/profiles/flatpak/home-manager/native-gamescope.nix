{ config, pkgs, lib, ... }:

with lib;
with pkgs;

let
    cfg = config.ethorbit.components.gaming.moonlight.flatpak.gamescope;
in

{
    home-manager.sharedModules = mkIf cfg.enable [ {
        xdg.desktopEntries."gamescope-moonlight" = mkMerge [
            cfg.desktop.defaultProps
            {
                name = "Moonlight (Gamescope)";
                comment = ''Stream games and other applications from another PC running Sunshine or GeForce Experience inside Gamescope'';
                exec = config.ethorbit.components.gaming.dependencies.gamescope.wrappers."moonlight".wrapper.outPath;
            }
        ];
    } ];
}
