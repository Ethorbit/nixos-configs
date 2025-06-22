{ config, ... }:

let
    cfg = config.ethorbit.components.gaming.roblox.flatpak;
in
{
    imports = [
        ./options.nix
        ./home-manager.nix
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."roblox-game" = {
        script = cfg.game.gamescope.scripts.normal;
    };

    ethorbit.components.gaming.dependencies.gamescope.wrappers."roblox-studio" = {
        script = cfg.studio.gamescope.scripts.normal;
    };
}
