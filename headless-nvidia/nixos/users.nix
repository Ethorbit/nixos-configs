{ config, ... }:

{
    ethorbit.users.primary.username = "nvidia";
    users = {
        groups.${config.ethorbit.users.primary.username}.gid = "1000";
        users.${config.ethorbit.users.primary.username} = {
            extraGroups = [ "wheel" "docker" ];
        };
    };
}
