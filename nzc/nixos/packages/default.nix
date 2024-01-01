{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # We must override the docker packages to ensure it stays compatible with NZC
        (import ./derivations/updated-docker.nix { inherit pkgs; inherit lib; }).docker_24_0_0
        git
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
