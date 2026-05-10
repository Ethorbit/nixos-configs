{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        lxcfs
        apparmor-pam
        apparmor-utils
        apparmor-parser
        apparmor-profiles
        apparmor-bin-utils
    ];
}
