{ config, lib, pkgs, ... }:

{
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
        driSupport = true;
        driSupport32Bit = true;
    };
}
