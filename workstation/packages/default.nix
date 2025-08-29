{ config, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
        distrobox
        flatpak-builder

        coturn
        neofetch

        libreoffice-qt

        virtiofsd
        virt-viewer

        keepassxc

        ethorbit.filen-cli
        filezilla
        sshfs
        ntfs3g

        yt-dlp
        ethorbit.yt-dlp-wrapper

        # steals your data
        #firefox
        # can't play YouTube correctly
        #(symlinkJoin {
        #    name = "ungoogled-chromium-wrapped";
        #    paths = [
        #        ungoogled-chromium
        #    ];
        #    buildInputs = [ makeWrapper ];
        #    postBuild = ''
        #        ${config.ethorbit.components.web-browsing.chromium.wrappers.videoEncoding}
        #    '';
        #})
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
        #godot_4-mono
        #dotnet-sdk
        #godot_4
        krita
        ethorbit.taggui  
    ];
}
