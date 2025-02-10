{ config, ... }:

{
    imports = [
        ../../../../packages/python/steam-acolyte
    ];

    environment.systemPackages = [
        config.ethorbit.pkgs.python.steam-acolyte
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam" = {};
    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam-offline" = {};
}
