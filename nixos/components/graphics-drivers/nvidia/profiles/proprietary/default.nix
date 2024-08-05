{ config, lib, pkgs, ... }:

let
    package = config.ethorbit.graphics.nvidia.proprietary.selectedPackage;
in
{
    options = with lib; {
        ethorbit.graphics.nvidia.proprietary.selectedPackage = mkOption {
            type = types.package;
            #default = config.boot.kernelPackages.nvidiaPackages.production;
            # Partly taken from https://discourse.nixos.org/t/nvidia-drivers-update/33872/3
            # I needed a way to continue using the old driver since the new one isn't patched upstream yet..
            default = (pkgs.old.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.production;
        };
    };

    config = with pkgs; {
        nixpkgs.config.nvidia.acceptLicense = true;
        boot.blacklistedKernelModules = [ "nouveau" ];

        hardware.nvidia = {
            package = nvidia-patch.patch-nvenc (nvidia-patch.patch-fbc package);
            modesetting.enable = true;
            powerManagement.enable = false;
            powerManagement.finegrained = false;
            nvidiaSettings = true;
            open = false;
        };
#fuck
        hardware.opengl.extraPackages = [ nvidia-vaapi-driver ];
        services.xserver.videoDrivers = [ "nvidia" ];

        environment.variables = with lib; {
            LIBVA_DRIVER_NAME = mkDefault "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = mkDefault "nvidia";
            NVD_BACKEND = mkDefault "direct";
            GBM_BACKEND = mkDefault "nvidia-drm";
        };
    };
}
