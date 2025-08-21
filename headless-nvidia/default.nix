{ config, pkgs, ... }:

{
    imports = [
        ./hardware-configuration.nix
        ./users.nix
        ../nixos/components/containers/docker
        ../nixos/components/graphics-drivers/nvidia/profiles/proprietary
    ];

    services.openssh = {
        enable = true;
        settings = {
            PermitRootLogin = "no";
            PasswordAuthentication = false;
        };
    };
}
