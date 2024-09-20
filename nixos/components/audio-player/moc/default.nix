{ config, pkgs, ... }:

{
    imports = [
        ../../../home-manager/moc
        ./desktop.nix
    ];

    xdg.mime.defaultApplications = {
        "audio/*" = [ "moc.desktop" ];
        "audio/opus" = [ "moc.desktop" ];
    };
}
