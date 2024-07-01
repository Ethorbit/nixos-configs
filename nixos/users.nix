{ config, lib, pkgs, ... }:

with lib;
{
    users.groups = {
        "${config.ethorbit.users.primary.username}".gid = mkDefault 1000;
        power = {};
    };

    age.secrets."users/primary/password" = { file = ./secrets/users/primary/pass.age; };
    users.users."${config.ethorbit.users.primary.username}" = {
        isNormalUser = mkDefault true;
        uid = mkDefault 1000;
        group = "${config.ethorbit.users.primary.username}";
        hashedPasswordFile = mkDefault config.age.secrets."users/primary/password".path;
        openssh.authorizedKeys.keys = mkDefault [ "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAID/m67X4bZrhN86eFAAp3RGEzhzUp0k1WAP7dw31fAVS ethorbit@nixos" ];
        # zsh is way more responsive and feature rich compared to ble.sh bash
        # mkDefault throws error, so just comment if you want something else
        # but honestly, you shouldn't need another shell because zsh is perfect <3
        shell = mkForce pkgs.zsh;
    };
}
