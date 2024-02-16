{ config, pkgs, ... }:

{
    age.secrets."users/nzc/password" = { file = ./secrets/users/nzc/pass.age; };
    
    ethorbit.users.primary.username = "nzc";
    
    users = {
        mutableUsers = false;

        groups."nzc" = {
            gid = 1000;
        };

        users = {
            "root" = {
                shell = ''${pkgs.shadow}/bin/nologin'';
                hashedPassword = "!";
            };

            "nzc" = {
                isNormalUser = true;
                uid = 1000;
                group = "nzc";
                extraGroups = [ "wheel" "docker" ];
                hashedPasswordFile = config.age.secrets."users/nzc/password".path;
                openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos" ];
            };
        };
    };
}
