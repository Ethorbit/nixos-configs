{ config, ... }:

{
    age.secrets."users/media/password" = { file = ./secrets/users/media/pass.age; };
    
    ethorbit.users.primary.username = "media";
    
    users = {
        groups."media" = {
            gid = 1000;
        };

        users = {
            "media" = {
                isNormalUser = true;
                uid = 1000;
                group = "media";
                hashedPasswordFile = config.age.secrets."users/media/password".path;
                openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos" ];
            };
        };
    };
}
