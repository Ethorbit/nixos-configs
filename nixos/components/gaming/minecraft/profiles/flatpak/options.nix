{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.minecraft.launcher.flatpak = {
        appName = mkOption {
            type = types.str;
            default = "org.prismlauncher.PrismLauncher";
        };

        gamescope = {
            enable = mkOption {
                type = types.bool;
                default = false;
            };

            flags = mkOption {
                type = types.listOf types.str;
                default = [
                    "-r 60"
                    "-w 1920"
                    "-h 1080"
                    "-W 1920"
                    "-H 1080"
                    "-f"
                    "--immediate-flips"
                    "--force-grab-cursor"
                ];
            };
        };
    };
}
