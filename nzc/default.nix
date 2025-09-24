{ ... }:

{
    imports = [
        ../nixos/components/programming/ide
        ./hardware.nix
        ./boot.nix
        ./packages
        ./users.nix
        ./services
        ./networking
        ./home-manager
    ];

    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
    virtualisation.docker.enable = true;
}
