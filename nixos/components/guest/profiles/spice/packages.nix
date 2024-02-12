{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        spice-vdagent
    ];
}
