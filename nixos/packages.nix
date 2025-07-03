{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        home-manager
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
