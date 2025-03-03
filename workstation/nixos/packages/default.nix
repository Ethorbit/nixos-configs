{ config, pkgs, ... }:

{
    imports = [
        ./scripts
        ../../../nixos/packages/script/mount-wait
        ../../../nixos/packages/script/yt-dlp-wrapper
        ../../../nixos/packages/script/mount-sshfs-run-service
        ../../../nixos/packages/node/filen-cli
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

        config.ethorbit.pkgs.node.filen-cli
        filezilla
        sshfs

        yt-dlp
        config.ethorbit.pkgs.script.yt-dlp-wrapper

        #firefox
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

        (symlinkJoin {
            name = "ungoogled-chromium-wrapped";
            paths = [
                ungoogled-chromium
            ];
            buildInputs = [ makeWrapper ];
            postBuild = ''
                ${config.ethorbit.components.web-browsing.chromium.wrappers.videoEncoding}
            '';
        })

        audacity
        blender
        #godot_4-mono
        #dotnet-sdk
        #godot_4
        #gimp
        krita
        kdenlive
        obs-studio
    ];
}
