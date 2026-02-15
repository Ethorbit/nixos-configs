{ config, pkgs, lib, ... }:

{
    config = lib.mkIf (config.system.nixos.release >= "24.11") {
        hardware.graphics = with pkgs; {
            extraPackages = [
                mesa.drivers
            ];
            extraPackages32 = [
                driversi686Linux.mesa.drivers
            ];
        };
    };
}
