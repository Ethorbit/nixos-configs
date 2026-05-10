{ ... }:

{
    imports = [
        ../nixos/components/networking/systemd
        ../nixos/components/programming/ide
        ../nixos/components/containers/docker
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
    };

    networking.hostName = "nzc";
    security.apparmor.enable = true;
    virtualisation.lxc.lxcfs.enable = true;
}
