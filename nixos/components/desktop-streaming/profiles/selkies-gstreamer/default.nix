# This component is a port of the nvidia-egl-desktop docker container
# So unless your system is headless and meant for dedicated desktop streaming, put this inside a container
# If you just want a quick way to share your current desktop, use a different solution because that's not what this is for.

#
# Read these for further information:
# https://github.com/selkies-project/selkies-gstreamer
# https://github.com/selkies-project/docker-nvidia-egl-desktop
#

{ config, pkgs, ... }:

{
    imports = [
        ../../../../packages/selkies-gstreamer
        ./options.nix
        ./environment.nix
        ./services
        ./packages.nix
        ./users.nix
        ./input.nix
    ];
}
