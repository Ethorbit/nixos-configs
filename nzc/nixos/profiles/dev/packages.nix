{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        dnsmasq
        firefox
        chromium
    ];
}
