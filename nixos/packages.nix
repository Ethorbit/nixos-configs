{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bash
        killall
    ];
}
