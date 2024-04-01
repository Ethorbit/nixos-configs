{ config, pkgs, ... }:

{
    age.secrets."users/workstation/password" = { file = ./secrets/users/workstation/pass.age; };
    
    ethorbit.users.primary.username = "workstation";
    
    users = {
        mutableUsers = false;

        groups."workstation" = {
            gid = 1000;
        };

        users = {
            "root" = {
                shell = ''${pkgs.shadow}/bin/nologin'';
                hashedPassword = "!";
            };

            "workstation" = {
                isNormalUser = true;
                uid = 1000;
                group = "nzc";
                extraGroups = [ "wheel" ];
                hashedPasswordFile = config.age.secrets."users/workstation/password".path;
                openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos" ];
            };
        };
    };
}