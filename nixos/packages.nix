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
        # Thirdparty tool that's recommended by git
        # instead of using git filter-branch
        python313Packages.git-filter-repo
        gh
        sudo
        vim
    ];
}
