{ config, pkgs, ... }:

{
    users = {
        mutableUsers = false;

        groups."container".gid = 1001;

        # workstation uses sudo and can do nixos-container root-login 
        # to access root on containers
        users."root" = {
            hashedPassword = "!";
        };
    };
}
