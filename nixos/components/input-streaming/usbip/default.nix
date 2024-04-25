{ config, pkgs, ... }:

{
    imports = [
        ./services.nix
    ];

    environment.systemPackages = with pkgs; [
        linuxPackages.usbip
    ];

    boot.kernelModules = [ "usbip_core" "usbip_host" ];
}
