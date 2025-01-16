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

{
    imports = [
        ./offline.nix
        ./mangohud.nix
    ];

    environment.systemPackages = with pkgs; [
        config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.normal
    ];

    home-manager.sharedModules = mkIf config.ethorbit.components.gaming.steam.flatpak.gamescope.enable [ {
        xdg.desktopEntries."gamescope-steam" = mkMerge [
            config.ethorbit.components.gaming.steam.flatpak.gamescope.desktop.defaultProps
            {
                name = "Steam (Gamescope)";
                comment = "Application for managing and playing games on Steam, inside Gamescope";
                exec = "${config.ethorbit.components.gaming.steam.flatpak.gamescope.wrappers.normal}/bin/gamescope-steam.sh";
            }
        ];
    } ];
}
