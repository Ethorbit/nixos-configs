{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        mesa
        mesa-demos
    ];

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
        extraPackages = with pkgs; [
            mesa.drivers
        ];
    };
}
