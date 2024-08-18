{ config, ... }:

{
    imports = [
        ../../../../../../nixos/components/programming/ide
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
