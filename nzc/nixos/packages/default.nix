{ config, lib, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # We must override the docker packages to ensure they are compatible with nzc-docker
        (import ./updated-docker.nix { inherit pkgs; inherit lib; }).docker_24_0_0
        (import ./updated-docker-compose.nix { inherit pkgs; inherit lib; })
        # Current nixpkgs is using LXCFS 4.0.12, which is pretty old now.
        unstable.lxcfs
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
        apparmor-kernel-patches
    ];
}
