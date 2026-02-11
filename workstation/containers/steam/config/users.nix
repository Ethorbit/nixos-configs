{ config, ... }:

let
    cfg = config.ethorbit.workstation.container.steam;
in
{
    ethorbit.users.primary.username = cfg.username;
    users = {
        allowNoPasswordLogin = true;
        users."${config.ethorbit.users.primary.username}" = {
            linger = true;
            extraGroups = [ "video" "input" "audio" ];
        };
    };
}
