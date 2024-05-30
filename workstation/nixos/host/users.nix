{ config, pkgs, ... }:

{
    ethorbit.users.primary.username = "workstation";
    
    users = {
        users = {
            # to allow Traefik to support Docker container labels
            "traefik" = {
                extraGroups = [ "docker" ];
            };

            "workstation" = {
                extraGroups = [ "wheel" "docker" "container" "audio" "video" "input" ];
            };
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
