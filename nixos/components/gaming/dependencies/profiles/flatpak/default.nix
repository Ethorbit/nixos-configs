{ config, ... }:

{
    imports = [
        ../../.
        ./options.nix
        ./home-manager.nix
    ];

    programs.gamescope = {
        enable = true;
        # capSysNice = true; # This won't work because of stubborn linux kernel
    };
}
