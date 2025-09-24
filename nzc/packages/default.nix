{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        docker
        lxcfs
        bash
        curl
        git
        sudo
        envsubst
        gnumake
        openssl
        lsof
        apparmor-pam
        apparmor-utils
        apparmor-parser
        apparmor-profiles
        apparmor-bin-utils
    ];
}
