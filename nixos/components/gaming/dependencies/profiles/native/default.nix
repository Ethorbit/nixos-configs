{ config, lib, pkgs, ... }:

with pkgs;

{
    imports = [
        ../../.
    ];

    nixpkgs.overlays = [
        (final: prev: {
            proton-ge-bin-11-1 = proton-ge-bin.overrideAttrs (old: rec {
                version = "GE-Proton11-1";
                src = final.fetchzip {
                    url = "https://github.com/GloriousEggroll/proton-ge-custom/releases/download/GE-Proton11-1/GE-Proton11-1.tar.gz";
                    hash = "sha256-I7SSvzQQ/NqdvwjpJ9IFFtAaTS+rgHUyXx0us1vIOnw=";
                };
            });
        })
    ];

    environment.systemPackages = with pkgs; [
        mangohud
        protontricks
    ];
}
