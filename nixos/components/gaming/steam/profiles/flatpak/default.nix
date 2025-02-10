# If you want good performance: switch to AMD.
# If you don't use AMD and want good performance: don't use Gamescope.
# If you don't use AMD and want to use Gamescope and have good performance:
#   see ./options.nix
#   enable gamescope and launch its .desktop shortcuts
#
# Check home-manager/default.nix for more info.

{ config, pkgs, ... }:

let
    cfg = config.ethorbit.components.gaming.steam.flatpak.gamescope;
in
{
    imports = [
        ../.
        ../../../dependencies/profiles/flatpak
        ./options.nix
        ./home-manager
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam" = {
        script = cfg.scripts.acolyte.normal;
    };

    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam-offline" = {
        script = cfg.scripts.acolyte.offline;
    };
}
