# Useful for accessing Windows VM(s?) or remote systems
# maybe even GPU passthrough --> Windows --> GPU-PV --> multiple Windows guests w/ Sunshine

{ config, ... }:

let
    id = "${config.ethorbit.components.gaming.moonlight.flatpak.appName}";
in
{
    # As much as I want to do this, it's causing the rendering to freeze up
    # my best guess is it's because Moonlight and Gamescope compete for resources
    #ethorbit.components.gaming.moonlight.flatpak.gamescope.enable = true;

    home-manager.users.${config.ethorbit.users.primary.username} = {
        home.file.".config/systemd/user/app-flatpak-${id}-.scope.d/slice.conf".text = ''
            [Scope]
            Slice=gaming.slice
        '';
    };
}
