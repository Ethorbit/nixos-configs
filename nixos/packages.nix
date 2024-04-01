{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bash
        screen
        killall
        file
        pciutils
        lm_sensors
        restic
        unzip
        unrar
        p7zip
        whois
        wget
        git
        sudo
    ];
}
