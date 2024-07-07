{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        blender
    ];
}
