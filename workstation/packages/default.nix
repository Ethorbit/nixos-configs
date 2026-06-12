{ config, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    environment.systemPackages = with pkgs; [
        old.neofetch

        libreoffice-qt

        keepassxc

        obs-cmd
        virt-viewer
        moonlight-qt

        distrobox
        flatpak-xdg-utils

        ethorbit.filen-cli
        filezilla
        sshfs
        mariadb

        unstable.yt-dlp
        ethorbit.yt-dlp-wrapper

        (symlinkJoin {
            name = "brave-wrapped";
            paths = [
                brave
            ];
            buildInputs = [ makeWrapper ];
            postBuild = ''
                ${config.ethorbit.components.web-browsing.brave.wrappers.videoEncoding}
            '';
        })

        lmms
        krita
        kid3
        #ethorbit.taggui

        pre-commit
        luajitPackages.ldoc
    ];
}
