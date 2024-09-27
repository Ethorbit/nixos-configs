{ config, lib, pkgs, ... }:

let
    package = config.ethorbit.graphics.nvidia.proprietary.selectedPackage;
in
{
    options = with lib; {
        ethorbit.graphics.nvidia.proprietary.selectedPackage = mkOption {
            type = types.package;
            default = config.boot.kernelPackages.nvidiaPackages.production;
            # If you want to use drivers from a different kernel
            example = literalExpression ''(pkgs.old.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.stable'';
        };
    };

    config = with pkgs; {
        nixpkgs.config.nvidia.acceptLicense = true;
        boot.blacklistedKernelModules = [ "nouveau" ];

        hardware.nvidia = {
            package = nvidia-patch.patch-nvenc (nvidia-patch.patch-fbc package);
            modesetting.enable = true;
            # This fixes graphical corruption caused by things such as suspension or LightDM lock screen
            # (Tested only on GTX 1060 6GB with i3WM, issue affected Godot Engine Mono and fixed by this)
            # Read more:
            # https://github.com/pop-os/nvidia-graphics-drivers/issues/133
            powerManagement.enable = true;
            powerManagement.finegrained = false;
            nvidiaSettings = true;
            open = false;
        };

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
