{ config, lib, pkgs, ... }:

with lib;
with pkgs;

let
    oldVersion = (
        builtins.compareVersions 
            config.system.nixos.release "25.05" 
            == -1
    );
in

{
    environment.systemPackages = [
        # error: The top-level kdenlive alias has been removed.

        # Please explicitly use kdePackages.kdenlive for the latest Qt 6-based version,
        # or libsForQt5.kdenlive for the deprecated Qt 5 version.
        (mkIf (oldVersion) kdenlive)
        (mkIf (!oldVersion) kdePackages.kdenlive)
    ];
}
