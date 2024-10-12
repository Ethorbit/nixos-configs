{ config, lib, ... }:

with lib;

{
    services.flatpak = {
        uninstallUnmanaged = true;
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
    };
}
