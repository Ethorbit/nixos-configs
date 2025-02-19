{ config, lib, ... }:

with lib;

{
    services.flatpak = {
        uninstallUnmanaged = mkDefault true;
        packages = [
            {
                appId = "com.github.tchx84.Flatseal";
                origin = "flathub";
            }
            {
                appId = "org.gtk.Gtk3theme.Adwaita-dark";
                origin = "flathub";
            }
        ];
        remotes = mkDefault [
            {
                name = "flathub";
                location = "https://flathub.org/repo/flathub.flatpakrepo";
            }
            {
                name = "flathub-beta";
                location = "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";
            }
        ];
        overrides = {
            global = {
                Environment = {
                    "GTK_THEME" = "Adwaita:dark";
                };
            };
        };
    };
}
