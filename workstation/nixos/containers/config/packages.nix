{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # (following morrolinux's guide for GPU accelerated container)
        libGL
        mesa
        virtualgl
    ];
}
