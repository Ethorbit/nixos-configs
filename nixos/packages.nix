{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        bash
        zsh
        screen
        killall
        file
        iotop
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
        gh
        sudo
        vim
    ];
}
