{ config, lib, pkgs, ... }:

{
    ethorbit.users.primary.username = "workstation";

    users = {
        mutableUsers = false;

        groups = {
            "builder" = {};
        };

        users = {
            "workstation" = {
                extraGroups = [ "wheel" "libvirtd" "docker" "container" "audio" "video" "input" ];
            };

            # just needed for emergency boots.
            "root".hashedPasswordFile = config.users.users."workstation".hashedPasswordFile;

            "builder" = {
                isNormalUser = true;
                group = "builder";
                hashedPasswordFile = config.users.users."workstation".hashedPasswordFile;
            };
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
