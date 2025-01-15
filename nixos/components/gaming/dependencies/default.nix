{ config, ... }:

{
    imports = [
        ./ananicy.nix
    ];

    programs.gamescope = {
        enable = true;
        # capSysNice = true; # This won't work because of stubborn linux kernel
    };

    programs.gamemode = {
        enable = true;
        enableRenice = true;
    };
}
