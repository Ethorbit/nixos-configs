{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./packages.nix
        ./users.nix
        ../../nixos/components/graphics-drivers/nvidia/profiles/proprietary
    ];

    virtualisation.docker = {
        enable = true;
        enableOnBoot = true;
        enableNvidia = true;
    };

    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
    };
}
