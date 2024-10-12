{ config, lib, pkgs, ... }:

{
    ethorbit.users.primary.username = "workstation";
    
    users = {
        mutableUsers = false;

        users = {
            "workstation" = {
                extraGroups = [ "wheel" "libvirtd" "docker" "container" "audio" "video" "input" ];
            };
        };

        # workstation uses sudo and can do nixos-container root-login
        # to access root on containers
        users."root" = {
            hashedPassword = "!";
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
