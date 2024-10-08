{ config, lib, pkgs, ... }:

{
    ethorbit.users.primary.username = "workstation";
    
    users = {
        groups."gaming" = {
            gid = 1010;
        };

        users = {
            # to allow Traefik to support Docker container labels
            "traefik" = {
                extraGroups = [ "docker" ];
            };

            "workstation" = {
                extraGroups = [ "wheel" "libvirtd" "docker" "container" "audio" "video" "input" ];
            };

            "gaming" = {
                isNormalUser = true;
                uid = 1010;
                shell = config.users.users."${config.ethorbit.users.primary.username}".shell;
                password = "gaming";
                group = "gaming";
            };
        };
    };

    security.sudo.wheelNeedsPassword = false;
}
