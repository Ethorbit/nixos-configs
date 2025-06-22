{ config, pkgs, lib, ... }:

{
    imports = [
        ../..
    ];

    services.xserver.displayManager.lightdm = {
        enable = lib.mkDefault true;
        greeters.gtk.enable = lib.mkDefault true;
    };

    environment.systemPackages = with pkgs; [
        lightlocker
    ];
}
