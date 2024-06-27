{ config, pkgs, ... }:

{
    imports = [
        #../../../../../../../nixos/components/web-browsing/firefox
        ../../../../../../../nixos/components/web-browsing/chromium
        ./packages.nix
        ./home-manager.nix
    ];

    #environment.variables = {
    #    BROWSER = "brave";
    #};
}
