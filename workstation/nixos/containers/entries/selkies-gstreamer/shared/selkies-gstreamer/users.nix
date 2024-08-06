{ config, lib, ... }:

{
    age.secrets."user/password" = { file = ./secrets/user/pass.age; };

    users = {
        users = {
            "${config.ethorbit.users.primary.username}" = {
                group = lib.mkForce "container";
                extraGroups = [ "video" "power" ];
                hashedPasswordFile = config.age.secrets."user/password".path;
            };
        };
    };
}
