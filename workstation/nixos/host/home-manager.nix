{ config, ... }:

{
    imports = [
        ../../../nixos/home-manager/wallpapers/ark_survival_evolved/aberration
    ];

    ethorbit.home-manager = {
        xdg.defaultBrowser = "chromium-browser.desktop";

        i3 = {
            workspace.monitor = {
                one = "HDMI-0";
            };

            music.refreshDirectory = "/home/${config.ethorbit.users.primary.username}/Music/Mp3 Player";
        };

        nvim.godotPath = "${config.ethorbit.pkgs.godot4-mono}/bin/godot4-mono";
    };
}
