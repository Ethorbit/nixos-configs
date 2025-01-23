{ config, pkgs, ... }:

with pkgs;

{
    environment.systemPackages = [
        i3
        i3-resurrect
        autotiling
    ];

    programs.i3lock = {
        enable = true;
        package = i3lock-fancy-rapid;
    };
}
