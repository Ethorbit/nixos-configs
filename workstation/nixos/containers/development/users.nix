{ config, ... }:

{
    age.secrets."users/development/password" = { file = ./secrets/users/development/pass.age; };
    
    ethorbit.users.primary.username = "development";
    
    users = {
        groups."development" = {
            gid = 1000;
        };

        users = {
            "development" = {
                isNormalUser = true;
                uid = 1000;
                group = "development";
                hashedPasswordFile = config.age.secrets."users/development/password".path;
                openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos" ];
            };
        };
    };
}
