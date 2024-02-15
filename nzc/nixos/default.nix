{ config, pkgs, ... }:

{
    imports = [
        ./hardware.nix
        ./boot.nix
        ./packages
        ./users.nix
        ./home-manager
        ./services
        ./networking
    ];

    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
    virtualisation.docker.enable = true;
}
