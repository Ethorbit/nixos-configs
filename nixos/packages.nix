{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bash
        screen
        killall
        file
        usbutils
        pciutils
        lm_sensors
        lsof
        restic
        unzip
        unrar
        p7zip
        whois
        wget
        git
        sudo
        vim
    ];
}
