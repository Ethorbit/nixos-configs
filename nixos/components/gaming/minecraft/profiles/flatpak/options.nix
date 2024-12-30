{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.minecraft.launcher.flatpak = {
        appName = mkOption {
            type = types.str;
            default = "org.prismlauncher.PrismLauncher";
        };
    };
}
