# Your user must turn on Flatpak for this to work.
#
# Your user's home-manager config must give access to Steam drives
# example:
#services.flatpak = {
#    overrides = {
#        "${config.ethorbit.components.gaming.steam.flatpak.appName}".Context = {
#            filesystems = [
#               "/mnt/games:rw"
#            ];
#        };
#    };
#};

{ config, pkgs, ... }:

{
    imports = [
        ./native-gamescope
        ./offline-mode.nix
    ];

    home-manager.sharedModules = [ {
        services.flatpak = {
            packages = [
                {
                    appId = "${config.ethorbit.components.gaming.steam.flatpak.appName}";
                    origin = "flathub";
                }
            ];
        };
    } ];

    # Symlink to ~/.steam
    systemd.user.tmpfiles.rules = [
        ''L %h/.var/app/${config.ethorbit.components.gaming.steam.flatpak.appName} - - - - %h/.steam''
    ];
}
