{ config, pkgs, ... }:

with pkgs;

let
    cfg = config.ethorbit.workstation.container.steam;
in
{
    environment.systemPackages = with pkgs; [
        (callPackage ./entrypoint.nix {})
    ] ++ (if cfg.debug then [
        mesa-demos
        vulkan-tools
        pkgsi686Linux.mesa-demos
        pkgsi686Linux.vulkan-tools
        xorg.xwininfo
    ] else []);
}
