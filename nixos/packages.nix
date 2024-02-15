{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bash
        restic
        killall
    ];
}
