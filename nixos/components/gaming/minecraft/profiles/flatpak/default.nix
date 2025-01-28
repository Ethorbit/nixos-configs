{ config, ... }:

let
    cfg = config.ethorbit.components.gaming.minecraft.launcher.flatpak;
in
{
    imports = [
        ./options.nix
        ./home-manager.nix
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."minecraft-launcher" = {
        script = cfg.gamescope.scripts.normal;
    };
}
