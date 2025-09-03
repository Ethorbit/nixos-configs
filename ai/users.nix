{ config, ... }:

{
    ethorbit.users.primary.username = "ai";

    users = {
        mutableUsers = false;

        users = {
            "ai" = {
                extraGroups = [ "wheel" "docker" "container" ];
            };

            # just needed for emergency boots.
            "root".hashedPasswordFile = config.users.users."ai".hashedPasswordFile;
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
