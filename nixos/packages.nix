{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bash
        screen
        killall
        file
        restic
        unzip
        unrar
        p7zip
        whois
        wget
		sudo
    ];
}
