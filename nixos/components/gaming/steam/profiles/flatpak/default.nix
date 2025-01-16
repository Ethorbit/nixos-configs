# If you want good performance: switch to AMD.
# If you don't use AMD and want good performance: don't use Gamescope.
# If you don't use AMD and want to use Gamescope and have good performance:
#   see ./options.nix
#   enable it and launch its gamescope .desktop shortcuts
#
# Check home-manager/default.nix for more info.

{ config, pkgs, ... }:

{
    imports = [
        ../../../dependencies/profiles/flatpak
        ./options.nix
        ./home-manager
    ];
}
