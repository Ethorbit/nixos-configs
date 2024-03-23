{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bash
        screen
        killall
        file
        restic
        unzip
        p7zip
        whois
    ];
}
