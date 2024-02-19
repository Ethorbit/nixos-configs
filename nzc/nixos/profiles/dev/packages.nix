{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        dnsmasq
        firefox
        chromium
        mysql-workbench
        filezilla
    ];
}
