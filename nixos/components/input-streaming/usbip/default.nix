{ config, pkgs, ... }:

{
    imports = [
        ./services.nix
    ];

    environment.systemPackages = with pkgs; [
        linuxPackages.usbip
    ];

    boot.kernelModules = [
        "vhci-hcd"
        "usbip_core"
        "usbip_host"
    ];
}
