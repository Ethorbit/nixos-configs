{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sudo
        firefox
        chromium
    ];
}
