{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        unstable.nexusmods-app
        (makeDesktopItem {
            name = "nexusmods-app";
            desktopName = "Nexus Mods";
            exec = "${unstable.nexusmods-app}/bin/NexusMods.App %f";
            terminal = false;
        })
    ];
}
