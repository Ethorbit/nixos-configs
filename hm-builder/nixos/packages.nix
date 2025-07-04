{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        i3
        i3-resurrect
        autotiling
        brave
    ];
}
