{ config, pkgs, lib, ... }:

{
    imports = [
        ./selkies-gstreamer.nix
        ../../../../../nixos/components/display-server/profiles/xserver
        ../../../../../nixos/components/window-manager/profiles/i3
    ];

    services.xserver.displayManager.sessionCommands = "${pkgs.i3}/bin/i3";
}
