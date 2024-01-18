{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        dnsmasq
    ];
}
