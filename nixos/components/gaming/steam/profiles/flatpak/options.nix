{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.steam.flatpak = {
        # You really shouldn't change these as stability has been setup
        # for these exact apps, however it's useful if you want to
        # reference them in your configs without copy-pasting
        appNames = {
            "steam" = mkOption {
                type = types.str;
                default = "com.valvesoftware.Steam";
            };

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
