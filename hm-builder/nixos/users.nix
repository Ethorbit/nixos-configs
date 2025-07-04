{ ... }:

{
    ethorbit.users.primary.username = "builder";

    users = {
        mutableUsers = false;

        users."builder" = {
            extraGroups = [ "wheel" ];
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
