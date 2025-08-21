{ config, lib, pkgs, ... }:

{
    # This version is still mostly secure as of 12/29/24
    # It has a few BuildKit vulnerabilities, but
    # seeing as nZC uses the same setup,
    # that should be fine.
    nixpkgs.config.permittedInsecurePackages = [
        "docker-24.0.9"
    ];

    environment.systemPackages = with pkgs; [
        # As of NixOS 24.11, docker 24.0 is provided in the package repo.
        docker_24
        # We must override the docker-compose package to ensure its compatible with nzc-docker
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
