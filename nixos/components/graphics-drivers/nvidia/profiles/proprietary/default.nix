{ config, lib, pkgs, ... }:

with lib;

let
    package = config.ethorbit.graphics.nvidia.proprietary.selectedPackage;
in
{
    options = {
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
            package = mkDefault (nvidia-patch.patch-nvenc (nvidia-patch.patch-fbc package));
            modesetting.enable = mkDefault true;
            # This fixes graphical corruption caused by things such as suspension or LightDM lock screen
            # (Tested only on GTX 1060 6GB with i3WM, issue affected Godot Engine Mono and fixed by this)
            # Read more:
            # https://github.com/pop-os/nvidia-graphics-drivers/issues/133
            powerManagement.enable = mkDefault true;
            powerManagement.finegrained = mkDefault false;
            nvidiaSettings = mkDefault true;
            open = mkDefault false;
        };

        hardware.opengl.extraPackages = [ nvidia-vaapi-driver ];
        services.xserver.videoDrivers = mkDefault [ "nvidia" ];

        environment.variables = with lib; {
            LIBVA_DRIVER_NAME = mkDefault "nvidia";
            __GLX_VENDOR_LIBRARY_NAME = mkDefault "nvidia";
            NVD_BACKEND = mkDefault "direct";
            GBM_BACKEND = mkDefault "nvidia-drm";
        };
    };
}
