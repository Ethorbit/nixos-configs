{ config, lib, pkgs, ... }:

with pkgs;

{
    imports = [
        ../../.
    ];

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

    environment.systemPackages = with pkgs; [
        mangohud
        protontricks
    ];
}
