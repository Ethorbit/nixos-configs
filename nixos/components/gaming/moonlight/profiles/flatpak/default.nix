{ config, ... }:

let
    cfg = config.ethorbit.components.gaming.moonlight.flatpak;
in
{
    imports = [
        ../.
        ../../../dependencies/profiles/flatpak
        ./options.nix
        ./home-manager
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."moonlight" = {
        script = cfg.gamescope.scripts.normal;
    };
}
