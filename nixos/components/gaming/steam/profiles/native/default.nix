# If you want better performance: disable compositor and use gamemoderun in game launch options
# If you want GOOD performance: switch to Windows or virtualize it and do GPU-Passthrough
# If it flickers your screen: use the flatpak profile instead \o/

{ config, lib, pkgs, ... }:

with pkgs;

{
    imports = [
        ../.
        ../../../dependencies/profiles/native
    ];

    programs.steam = {
        enable = true;
        protontricks.enable = true;
        #gamescopeSession.enable = true;

        extraPackages = with pkgs; [
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
            pkgsi686Linux.libpulseaudio
            alsa-plugins
            pkgsi686Linux.alsa-plugins
            libvorbis
            stdenv.cc.cc.lib
            libkrb5
            keyutils
        ];

        extraCompatPackages = with pkgs; [
            proton-ge-bin
        ];
    };
}
