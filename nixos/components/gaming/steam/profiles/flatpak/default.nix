# If you want better performance: disable compositor and use gamemoderun in game launch options
# If you want GOOD performance: switch to Windows or virtualize it and do GPU-Passthrough

# Your system must turn on Flatpak
# (both system and home-manager) for this to work!

{ config, pkgs, ... }:

{
    imports = [
        ./options.nix
        ./home-manager.nix
    ];
}
