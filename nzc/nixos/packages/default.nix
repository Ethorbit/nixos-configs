{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # We must override the docker packages to ensure they are compatible with NZC
        (import ./derivations/updated-docker.nix { inherit pkgs; inherit lib; }).docker_24_0_0
        (import ./derivations/updated-docker-compose.nix { inherit pkgs; inherit lib; })
        git
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
