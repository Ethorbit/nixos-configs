{ config, lib, pkgs, ... }:

let
    package = config.ethorbit.graphics.nvidia.proprietary.selectedPackage;
in
{
    options = with lib; {
        ethorbit.graphics.nvidia.proprietary.selectedPackage = mkOption {
            type = types.package;
            default = config.boot.kernelPackages.nvidiaPackages.production;
        };
    };

    config = {
        nixpkgs.config.nvidia.acceptLicense = true;

        environment.systemPackages = with pkgs; [
            nvidia-vaapi-driver
        ];

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
    };
}
