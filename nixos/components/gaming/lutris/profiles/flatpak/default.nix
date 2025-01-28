# See home-manager.nix for more info

{ config, pkgs, ... }:

let
    cfg = config.ethorbit.components.gaming.lutris.flatpak;
in
{
    imports = [
        ../.
        ../../../dependencies/profiles/flatpak
        ./options.nix
        ./home-manager
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."lutris" = {
        script = cfg.gamescope.scripts.normal;
    };
}
