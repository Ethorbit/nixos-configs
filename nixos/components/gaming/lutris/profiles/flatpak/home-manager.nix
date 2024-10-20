# Your user must turn on Flatpak for this to work.
#
# Lutris can access Steam and files selected
# from the host's File Picking Portal
#
# So you may need to give it access to your
# game files in some cases.
#
# Example:
#services.flatpak = {
#    overrides = {
#        "${config.ethorbit.components.gaming.lutris.flatpak.appName}".Context = {
#            filesystems = [
#               "/mnt/games:rw"
#            ];
#        };
#    };
#};

{ config, pkgs, ... }:

{
    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.lutris.flatpak.appName}";
                    origin = "flathub";
                }
            ];
        };
    } ];
}
