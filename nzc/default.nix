{ lib, ... }:

{
    imports = [
        ../nixos/components/networking/systemd
        ../nixos/components/programming/ide
        ../nixos/components/containers/docker
        ./options.nix
        ./hardware.nix
        ./boot.nix
        ./packages
        ./users.nix
        ./services
        ./networking
        ./home-manager
    ];

    nix = {
        distributedBuilds = false;
        buildMachines = [ ];

        # Garbage collector interferes with Arion nix file mounts
        gc.automatic = false;
    };

    networking.hostName = lib.mkDefault "nzc";
    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
}
