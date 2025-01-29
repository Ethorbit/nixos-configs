{ config, pkgs, ... }:

{
    imports = [
        ../.
        ../../../dependencies/profiles/native
    ];

    environment.systemPackages = with pkgs; [
        moonlight-qt
    ];
}
