{ config, pkgs, ... }:

{
    # don't know why it isn't just built with support by default
    # but ok, thanks Reddit.
    environment.systemPackages = with pkgs; [
        i3
    ];
}
