{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/components/display-server/profiles/xserver
        ../../nixos/components/display-manager/profiles/lightdm
        ../../nixos/components/window-manager/profiles/i3
        ../../nixos/services/feh/wallpaper
    ];

    services.displayManager = {
        defaultSession = "none+i3";
        autoLogin.user = config.ethorbit.users.primary.username;
    };
}
