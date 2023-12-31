{ config, pkgs, ... }:

{
    age.secrets."users/nzc/password" = { file = ./secrets/users/nzc/pass.age; };
    
    users = {
        mutableUsers = false;
        
        users = {
            root = {
                shell = ''${pkgs.shadow}/bin/nologin'';
                hashedPassword = "!";
            };

            nzc = {
                isNormalUser = true;
                extraGroups = [ "wheel" ];
                hashedPasswordFile = config.age.secrets."users/nzc/password".path;
                openssh.authorizedKeys.keys = [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos" ];
            };
        };
    };
}
