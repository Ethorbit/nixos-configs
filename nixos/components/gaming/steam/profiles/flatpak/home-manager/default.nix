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

            overrides = {
                "${config.ethorbit.components.gaming.steam.flatpak.appName}" = {
                    # Give it access to the Flatpak Gamescope portal
                    Context = {
                        filesystems = [ "xdg-run/gamescope-0:ro" ];
                        env = [
                            "LD_LIBRARY_PATH=/usr/lib/extensions/vulkan/gamescope/lib"
                            "PATH=/usr/lib/extensions/vulkan/gamescope/bin"
                        ];
                    };
                };
            };
        };
    } ];

    # Symlink to ~/.steam
    systemd.user.tmpfiles.rules = [
        ''L %h/.var/app/${config.ethorbit.components.gaming.steam.flatpak.appName} - - - - %h/.steam''
    ];
}
