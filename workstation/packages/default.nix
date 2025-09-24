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

        ethorbit.filen-cli
        filezilla
        sshfs

        yt-dlp
        ethorbit.yt-dlp-wrapper

        # so far, so good...
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
        lmms
        krita
        ethorbit.taggui  
    ];
}
