{ config, pkgs, lib, ... }:

with lib;
with pkgs;

let
    cfg = config.ethorbit.components.gaming.lutris.flatpak.gamescope;
in

{
    home-manager.sharedModules = mkIf cfg.enable [ {
        xdg.desktopEntries."gamescope-lutris" = mkMerge [
            cfg.desktop.defaultProps
            {
                name = "Lutris (Gamescope)";
                comment = ''Video Game Preservation Platform inside Gamescope'';
                exec = config.ethorbit.components.gaming.dependencies.gamescope.wrappers."lutris".wrapper.outPath;
            }
        ];
    } ];
}
