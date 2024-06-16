{ config, ... }:

{
    imports = [
        ../../../../../../nixos/components/containers/docker
        ./packages.nix
    ];

    users = {
        users = {
            "${config.ethorbit.users.primary.username}" = {
                extraGroups = [ "docker" ];
            };
        };
    };
}
