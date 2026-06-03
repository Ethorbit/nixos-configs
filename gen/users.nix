{ config, ... }:

{
    ethorbit.users.primary.username = "gen";

    users = {
        mutableUsers = false;

        users = {
            "gen" = {
                extraGroups = [ "wheel" "docker" "container" ];
                linger = true;
            };

            # just needed for emergency boots.
            "root".hashedPasswordFile = config.users.users."gen".hashedPasswordFile;
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
