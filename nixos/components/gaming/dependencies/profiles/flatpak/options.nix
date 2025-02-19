{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.gaming.dependencies.flatpak = {
        appNames = {
            "proton" = mkOption {
                type = types.str;
                default = "com.valvesoftware.Steam.CompatibilityTool.Proton-GE";
            };
            "protonup-qt" = mkOption {
                type = types.str;
                default = "net.davidotek.pupgui2";
            };
            # By default, Protontricks only has access to the Steam installation directory.
            # You will need to add filesystem permissions for additional Steam library locations, 
            # and other directories when running external EXEs.
            "protontricks" = mkOption {
                type = types.str;
                default = "com.github.Matoking.protontricks";
            };

            "gamescope23" = mkOption {
                type = types.str;
                default = "runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/23.08";
            };

            "gamescope24" = mkOption {
                type = types.str;
                default = "runtime/org.freedesktop.Platform.VulkanLayer.gamescope/x86_64/24.08";
            };

            "mangohud23" = mkOption {
                type = types.str;
                default = "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/23.08";
            };

            "mangohud24" = mkOption {
                type = types.str;
                default = "runtime/org.freedesktop.Platform.VulkanLayer.MangoHud/x86_64/24.08";
            };
        };
    };
}
