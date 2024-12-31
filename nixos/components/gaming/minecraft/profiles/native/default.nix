{ config, pkgs, ... }:

{
    imports = [
        ./home-manager.nix
    ];

    environment.systemPackages = with pkgs; [
        prismlauncher
    ];
}
