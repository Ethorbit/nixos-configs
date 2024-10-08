{ config, lib, ... }:

{
    imports = [
        ../../../nixos/home-manager/wallpapers/ark_survival_evolved/aberration
    ];

    home-manager.users."${config.ethorbit.users.primary.username}" = {
        xdg.userDirs.enable = true;
        xdg.userDirs.music = "/mnt/storage/Music";
        xdg.userDirs.pictures = "/mnt/storage/Pictures";
        xdg.userDirs.download = "/mnt/storage/Downloads";
        xdg.userDirs.documents = "/mnt/storage/Documents";
        xdg.userDirs.videos = "/mnt/storage/Videos";
    };

    ethorbit.home-manager = {
        xdg.defaults.browser = "chromium-browser.desktop";

        i3 = {
            workspace.monitor = {
                one = "HDMI-0";
            };

            music.refreshDirectory = "/mnt/storage/Music/Mp3 Player";
        };

        nvim.godotPath = "${config.ethorbit.pkgs.godot4-mono}/bin/godot4-mono";
    };
}
