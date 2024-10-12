{ config, pkgs, ... }:

{
    config.home-manager.sharedModules = [ {
        services.flatpak = {
            uninstallUnmanaged = true;
        };

        # Because apparently setting context in services.flatpak doesn't do anything :/
        home.file.".local/share/flatpak/overrides/global".text = ''
          [Context]
          filesystems=/run/current-system/sw/share/X11/fonts:ro;/nix/store:ro
        '';
    } ];
}
