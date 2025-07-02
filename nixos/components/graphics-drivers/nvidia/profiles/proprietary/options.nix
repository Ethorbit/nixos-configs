{ config, lib, ... }:

with lib;

{
    options.ethorbit.graphics.nvidia.proprietary = {
        selectedPackage = mkOption {
            type = types.package;
            default = config.boot.kernelPackages.nvidiaPackages.production;
            # If you want to use drivers from a different kernel
            example = literalExpression ''(pkgs.old.linuxPackagesFor config.boot.kernelPackages.kernel).nvidiaPackages.stable'';
        };

        powerLimit = {
            enable = mkOption {
                default = false;
                type = types.bool;
                description = "Whether or not to enable a power limit";
            };

            limit = mkOption {
                description = "The wattage power limit";
                type = types.int;
                default = 0;
            };
        };
    };
}
