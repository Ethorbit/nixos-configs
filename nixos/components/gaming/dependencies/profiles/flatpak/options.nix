{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.dependencies.flatpak = {
        appNames = {
            "proton" = mkOption {
                type = types.str;
                default = "com.valvesoftware.Steam.CompatibilityTool.Proton-GE";
            };

            "gamescope" = mkOption {
                type = types.str;
                default = "runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08";
            };

            "mangohud" = mkOption {
                type = types.str;
                default = "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08";
            };
        };
    };
}
