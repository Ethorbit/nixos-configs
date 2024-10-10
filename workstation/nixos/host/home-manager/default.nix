{ config, ... }:

{
    imports = [
        ./flatpak.nix
        ./xdg.nix
        ./i3.nix
        ../../../../nixos/home-manager/wallpapers/ark_survival_evolved/aberration
    ];

    ethorbit.home-manager = {
        nvim.godotPath = "${config.ethorbit.pkgs.godot4-mono}/bin/godot4-mono";
    };
}
