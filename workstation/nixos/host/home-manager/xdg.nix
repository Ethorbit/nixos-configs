{ config, ... }:

{
    ethorbit.home-manager.xdg.defaults.browser = "chromium-browser.desktop";

    home-manager.sharedModules = [ {
        xdg.userDirs.enable = true;
        xdg.userDirs.music = "/mnt/storage/Music";
        xdg.userDirs.pictures = "/mnt/storage/Pictures";
        xdg.userDirs.download = "/mnt/storage/Downloads";
        xdg.userDirs.documents = "/mnt/storage/Documents";
        xdg.userDirs.videos = "/mnt/storage/Videos";
    } ];
}
