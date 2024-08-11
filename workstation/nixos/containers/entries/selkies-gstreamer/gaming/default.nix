{ config, ... }:

{
    imports = [
        ../../../../../../nixos/components/gaming/profiles/steam
    ];

    programs.gamescope.enable = true;
}
