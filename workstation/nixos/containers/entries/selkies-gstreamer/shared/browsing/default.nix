{ config, pkgs, ... }:

{
    imports = [
        ../../../../../../../nixos/components/web-browsing/chromium
        ./packages.nix
        ./home-manager.nix
    ];
}
