{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        sudo
    ];
}
