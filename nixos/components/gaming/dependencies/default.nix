{ config, ... }:

{
    imports = [
        ./gamescope.nix
        ./ananicy.nix
    ];

    programs.gamemode = {
        enable = true;
        enableRenice = true;
    };
}
