{ config, inputs, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
        neofetch

        libreoffice-qt

        keepassxc

        obs-cmd
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

        lmms
        krita
        kid3
        #ethorbit.taggui

        pre-commit
        luajitPackages.ldoc
    ] ++ (with inputs.nixpkgs-gamedev.legacyPackages.${pkgs.system}; [
        godot-mono
        blender
        vpkedit
        vtfedit
    ]);
}
