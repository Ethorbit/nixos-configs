{ config, ... }:

{
    services.flatpak = {
        enable = true;
        packages = [
            {
                appId = "com.obsproject.Studio";
                origin = "flathub";
            }
            {
                appId = "com.obsproject.Studio.Plugin.OBSVkCapture";
                origin = "flathub";
            }
            {
                appId = "org.freedesktop.Platform.VulkanLayer.OBSVkCapture/x86_64/24.08";
                origin = "flathub";
            }
        ];
    };
}
