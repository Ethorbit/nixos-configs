{ config, pkgs, ... }:

{
    imports = [
        ./home-manager.nix
        ./packages.nix
    ];

    hardware.pulseaudio = {
        enable = true;
        extraConfig = "unload-module module-suspend-on-idle";
    };

    services.ananicy.extraRules = [
        {
            name = "pulseeffects";
            type = "Player-Audio";
        }
        {
            name = ".pulseeffects-wrapped";
            type = "Player-Audio";
        }
    ];
}
