{ config, pkgs, ... }:

with pkgs;

let
    cfg = config.ethorbit.workstation.container.steam;
in
{
    environment.systemPackages = with pkgs; [
    ] ++ (if cfg.debug then [
        xorg.xwininfo
    ] else []);
}
