# I made these because running Steam under native Gamescope
# was the ONLY way I could get my games to run with more 
# than 60 fps in Gamescope
#
# Still, the FPS is lower with Gamescope than without Gamescope
# by about 20-30 frames, but I'm planning on switching to AMD
# soon since this is likely a proprietary driver problem

{ config, pkgs, lib, ... }:

with lib;
with pkgs;

let
    cfg = config.ethorbit.components.gaming.steam.flatpak.gamescope;
in

{
    imports = [
        ./offline.nix
    ];

    home-manager.sharedModules = mkIf cfg.enable [ {
        xdg.desktopEntries."gamescope-steam" = mkMerge [
            cfg.desktop.defaultProps
            {
                name = "Steam (Gamescope)";
                comment = "Application for managing and playing games on Steam, inside Gamescope";
                exec = config.ethorbit.components.gaming.dependencies.gamescope.wrappers."steam".wrapper.outPath;
            }
        ];
    } ];
}
