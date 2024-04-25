{ config, ... }:

{
    ethorbit.users.primary.username = "workstation";

    users.users."workstation" = {
        extraGroups = [ "wheel" "docker" ];
    };

    security.sudo.wheelNeedsPassword = false;
}
