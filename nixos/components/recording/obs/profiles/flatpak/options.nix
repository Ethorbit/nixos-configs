{ config, lib, ... }:

with lib;

{
    options.ethorbit.components.recording.obs.flatpak = {
        appIds = {
            obs = mkOption {
                type = types.str;
                default = "com.obsproject.Studio";
            };

            obsVkCapture = mkOption {
                type = types.str;
                default = "org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/25.08";
            };

            obsVkCapturePlugin = mkOption {
                type = types.str;
                default = "com.obsproject.Studio.Plugin.OBSVkCapture";
            };
        };
    };
}
