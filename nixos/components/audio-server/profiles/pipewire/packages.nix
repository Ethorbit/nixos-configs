{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        pipewire
        pavucontrol
    ];
}
