{ config, ... }:

{
    ethorbit.users.primary.username = "deck";

    users = {
        mutableUsers = false;

        users = {
            "deck" = {
                extraGroups = [ "wheel" ];
            };
        };

        # No need for root, we have sudo
        users."root" = {
            hashedPassword = "!";
        };
    };

    # Let deck user decrypt disks without password
    security.sudo.extraRules = [
        {
            users = [ "deck" ];
            commands = [
                {
                    command = "/run/current-system/sw/bin/decrypt.sh";
                    options = [ "NOPASSWD" ];
                }
                {
                    command = "${config.ethorbit.steamdeck.packages.decrypt.script.outPath}";
                    options = [ "NOPASSWD" ];
                }
            ];
        }
    ];
}
