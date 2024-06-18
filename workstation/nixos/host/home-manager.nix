{ config, ... }:

{
    imports = [
        ../../../nixos/home-manager/wallpapers/ark_survival_evolved/aberration
    ];

    ethorbit.home-manager.xdg.defaultBrowser = "chromium-browser.desktop";

    ethorbit.home-manager.i3 = {
        workspace.monitor = {
            one = "DP-3";
            two = "HDMI-0";
        };

        music.refreshDirectory = "/home/${config.ethorbit.users.primary.username}/Music/Mp3 Player";
    };
}
