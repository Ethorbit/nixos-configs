{ config, lib, pkgs, ... }:

{
    config.home-manager.sharedModules = [ {
        services.flatpak = {
            uninstallUnmanaged = lib.mkDefault true;
            packages = [
                {
                    appId = "com.github.tchx84.Flatseal";
                    origin = "flathub";
                }
            ];
        };

        # Because apparently setting context in services.flatpak doesn't do anything :/
        home.file.".local/share/flatpak/overrides/global".text = ''
          [Environment]
          GTK_THEME=Adwaita:dark

          [Context]
          filesystems=/run/current-system/sw/share/X11/fonts:ro;/nix/store:ro
        '';
    } ];
}
