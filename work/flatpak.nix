{ config, ... }:

{
    services.flatpak = {
        enable = true;
        packages = [
            {
                appId = "org.videolan.VLC";
                origin = "flathub";
            }
            {
                appId = "org.remmina.Remmina";
                origin = "flathub";
            }
        ];
    };
}
