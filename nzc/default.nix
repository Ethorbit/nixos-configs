{ config, pkgs, ... }:

{
    imports = [
        ./hardware.nix
        ./boot.nix
        ./packages
        ./users.nix
        ./services
        ./networking
    ];

    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
    virtualisation.docker.enable = true;
}
