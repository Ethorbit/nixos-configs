{ config, ... }:

{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.minecraft.launcher.flatpak.appName}";
                    origin = "flathub";
                }
            ];
        };
    } ];
}
