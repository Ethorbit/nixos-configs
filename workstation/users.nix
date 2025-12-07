{ config, lib, pkgs, ... }:

let
    altUser = {
        isNormalUser = true;
        extraGroups = [ "games" ];
        hashedPasswordFile = config.users.users."workstation".hashedPasswordFile;
    };
in
{
    ethorbit.users.primary.username = "workstation";

    users = {
        mutableUsers = false;

        groups = {
            "builder" = {};
            "games" = {};
        };

        users = {
            "workstation" = {
                extraGroups = [ "games" "wheel" "libvirtd" "docker" "container" "audio" "video" "input" ];
            };

            # Alt accounts
            "builder" = altUser // {
                group = "builder";
            };

            # just needed for emergency boots.
            "root".hashedPasswordFile = config.users.users."workstation".hashedPasswordFile;
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
