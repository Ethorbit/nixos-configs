{ config, lib, pkgs, ... }:

{
    ethorbit.users.primary.username = "work";

    users = {
        mutableUsers = false;

        users = {
            "work" = {
                extraGroups = [ "wheel" "networkmanager" "audio" "video" "input" ];
            };
        };

        # work uses sudo
        users."root" = {
            hashedPassword = "!";
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
