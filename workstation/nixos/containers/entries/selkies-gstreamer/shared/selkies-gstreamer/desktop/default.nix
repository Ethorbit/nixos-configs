{ config, pkgs, lib, ... }:

{
    imports = [
        ./selkies-gstreamer.nix
        ../../../../../../../../nixos/components/display-server/profiles/xserver
        ../../../../../../../../nixos/components/window-manager/profiles/i3
        ../../../../../../../../nixos/services/feh/wallpaper
        ../../../../../../../../nixos/home-manager/wallpapers/space
    ];

    services.xserver.displayManager.sessionCommands = "${pkgs.i3}/bin/i3";

    # Selkies Gstreamer doesn't forward the windows key even in fullscreen, so we need to change it.
    # The browser connecting will need to have its shortcuts disabled to be able to use all the i3 keymaps.
    ethorbit.home-manager.i3.keys.mod = "${config.ethorbit.home-manager.i3.keys.alt}";
}
