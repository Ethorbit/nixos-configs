{ config, lib, pkgs, ... }:

{
    imports = [
        ./before-24.11.nix
    ];

    environment = {
        systemPackages = with pkgs; [
            mesa
            mesa-demos
        ];

        variables = {
            VDPAU_DRIVER = lib.mkDefault "va_gl";
        };
    };

    hardware.opengl = {
        enable = true;
        driSupport32Bit = true;
    };
}
