# If you want better performance: disable compositor and use gamemoderun in game launch options
# If you want GOOD performance: switch to Windows or virtualize it and do GPU-Passthrough
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
