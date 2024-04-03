{ config, pkgs, ... }:

let
    package = config.boot.kernelPackages.nvidiaPackages.production;
in
{
    boot.blacklistedKernelModules = [ "nouveau" ];

    hardware.nvidia = {
        package = pkgs.nvidia-patch.patch-nvenc (pkgs.nvidia-patch.patch-fbc package);
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        nvidiaSettings = true;
        open = false;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
}
