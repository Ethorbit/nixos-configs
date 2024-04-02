{ config, ... }:

{
    boot.blacklistedKernelModules = [ "nouveau" ];

    hardware.nvidia = {
        package = config.boot.kernelPackages.nvidiaPackages.production;
        modesetting.enable = true;
        powerManagement.enable = false;
        powerManagement.finegrained = false;
        nvidiaSettings = true;
        open = false;
    };

    services.xserver.videoDrivers = [ "nvidia" ];
}
