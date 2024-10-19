# If you want better performance: disable compositor and use gamemoderun in game launch options
# If you want GOOD performance: switch to Windows or virtualize it and do GPU-Passthrough
# If it flickers your screen: use the flatpak profile instead \o/

{ config, lib, pkgs, ... }:

with pkgs;

{
    imports = [
        ../../../dependencies/profiles/native
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
}
