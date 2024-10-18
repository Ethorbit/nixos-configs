# If you want better performance: disable compositor and use gamemoderun in game launch options
# If you want GOOD performance: switch to Windows or virtualize it and do GPU-Passthrough
# If it flickers your screen, use the flatpak profile instead \o/

# at least, that's how things are currently as nobody
# in the Linux community knows what to do.

{ config, lib, pkgs, ... }:

with pkgs;

{
    # Similar to the Flatpak, we use a version-locked Proton-GE package
    # to ensure a stable solution is always available
    nixpkgs.overlays = [
        (final: prev: {
            proton-ge-bin-8-14 = proton-ge-bin.overrideAttrs (old: {
                src = fetchzip {
                    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton8-14/GE-Proton8-14.tar.gz";
                    hash = "sha256-/68J3aVmHqrrcNk4DkYSBzfNyIQmbcUGg3yOlDq1ts8=";
                };
            });
        })
    ];

    programs.steam = {
        enable = true;
        gamescopeSession.enable = true;
        package = pkgs.steam.override {
            extraPkgs = pkgs: with pkgs; [
                # Tools useful for launch options
                mangohud
                gamescope
                gamemode

                # Needed to fix gamescope issues
                xorg.libXcursor
                xorg.libXi
                xorg.libXinerama
                xorg.libXScrnSaver
                libpng
                libpulseaudio
                libvorbis
                stdenv.cc.cc.lib
                libkrb5
                keyutils
            ];
        };
        extraCompatPackages = with pkgs; [
            proton-ge-bin-8-14
        ];
    };

    programs.gamescope = {
        enable = true;
        capSysNice = false; # This breaks everything. Yes it's needed to fix performance issues. Yes you're out of luck.
    };

    programs.gamemode.enable = true;
}
