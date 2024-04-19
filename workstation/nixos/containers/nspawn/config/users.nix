{ config, ... }:

{
    age.secrets."user/password" = { file = ../../secrets/user/pass.age; };

    systemd.tmpfiles.rules = [
      "f /var/lib/systemd/linger/${config.ethorbit.users.primary.username}"
      "d /etc/opt/VirtualGL 750 root vglusers -"
    ];

    users.groups.vglusers = {};

    users = {
        users = {
            "${config.ethorbit.users.primary.username}" = {
                linger = true;
                group = "container";
                extraGroups = [ "video" "power" "vglusers" ];
                uid = 1000 + config.ethorbit.workstation.xorg.sessionNumbers.${config.ethorbit.users.primary.username};
                hashedPasswordFile = config.age.secrets."user/password".path;
            };
        };
    };
}
