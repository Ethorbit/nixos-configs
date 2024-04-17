{ config, ... }:

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
                isNormalUser = true;
                group = "container";
                extraGroups = [ "video" "power" "vglusers" ];
                uid = 1000 + config.ethorbit.workstation.xorg.sessionNumbers.${config.ethorbit.users.primary.username};
                hashedPasswordFile = config.age.secrets."user/password".path;
                openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos" ];
            };
        };
    };
}
