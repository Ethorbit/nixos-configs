{ config, ... }:

{
    ethorbit.users.primary.username = "nvidia";
    users = {
        users.${config.ethorbit.users.primary.username} = {
            extraGroups = [ "wheel" "docker" ];
        };
    };
}
