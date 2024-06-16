{ config, pkgs, ... }:

{
    imports = [
        ./packages.nix
        ../../../../../../../nixos/components/web-browsing/firefox
        ../../../../../../../nixos/components/web-browsing/chromium
    ];
}
