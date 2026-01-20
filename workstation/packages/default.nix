{ config, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
        neofetch

        libreoffice-qt

        keepassxc

        virt-viewer
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

        audacity
        blender
        godotPackages_4_4.godot
        vpkedit
        lmms
        krita
        kid3
        ethorbit.taggui
        ethorbit.gm-autorun-ng
    
        pre-commit
    ];
}
