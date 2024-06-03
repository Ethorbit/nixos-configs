{ config, ... }:

{
    imports = [
        ../../../../../../nixos/components/containers/docker
    ];

    users = {
        users = {
            "${config.ethorbit.users.primary.username}" = {
                extraGroups = [ "docker" ];
            };
        };
    };
}
