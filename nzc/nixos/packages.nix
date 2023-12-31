{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        grub2
        sudo
        lxcfs
        envsubst
        openssl
        lsof
        apparmor-pam
        apparmor-utils
        apparmor-parser
        apparmor-profiles
        apparmor-bin-utils
        apparmor-kernel-patches
    ];
}
