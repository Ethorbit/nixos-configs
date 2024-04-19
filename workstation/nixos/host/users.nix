{ config, pkgs, ... }:

{
    ethorbit.users.primary.username = "workstation";
    
    users = {
        users = {
            "workstation" = {
                extraGroups = [ "wheel" "docker" "container" "audio" "video" "input" ];
            };
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
