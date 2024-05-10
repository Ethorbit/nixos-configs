{ config, lib, ... }:

{
    age.secrets."user/password" = { file = ./secrets/user/pass.age; };

    systemd.tmpfiles.rules = [
      "f /var/lib/systemd/linger/${config.ethorbit.users.primary.username}"
      "d /etc/opt/VirtualGL 750 root vglusers -"
    ];

    users.groups.vglusers = {};

    users = {
        users = {
            "${config.ethorbit.users.primary.username}" = {
                linger = true;
                group = lib.mkDefault "container";
                extraGroups = [ "video" "power" "vglusers" ];
                hashedPasswordFile = config.age.secrets."user/password".path;
            };
        };
    };
}
