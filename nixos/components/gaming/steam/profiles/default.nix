{ pkgs, ... }:

{
    environment.systemPackages = [
        pkgs.ethorbit.steam-acolyte
    ];

    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam" = {};
    ethorbit.components.gaming.dependencies.gamescope.wrappers."steam-offline" = {};
}
