{ config, pkgs, ... }:

{
    # Because apparently setting context in services.flatpak doesn't do anything :/
    config.home-manager.sharedModules = [ {
        home.file.".local/share/flatpak/overrides/global".text = ''
          [Context]
          filesystems=/run/current-system/sw/share/X11/fonts:ro;/nix/store:ro
        '';
    } ];
}
