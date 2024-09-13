{ config, pkgs, ... }:

{
    imports = [
        ./scripts
        ../../../../nixos/packages/yt-dlp-wrapper
        ../../../../nixos/packages/mount-sshfs-run-service
        ../../../../nixos/packages/godot4-mono
    ];

    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
        coturn
        neofetch

        libreoffice-qt

        # weird ToolBar.qml error, I'll just install it as a Flatpak instead
        #moonlight-qt
        virtiofsd
        virt-viewer

        keepassxc

        filezilla
        sshfs

        yt-dlp
        config.ethorbit.pkgs.yt-dlp-wrapper

        #firefox
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
        config.ethorbit.pkgs.godot4-mono
        #godot_4
        gimp
        kdenlive
        obs-studio
    ];

    services.flatpak = {
        enable = true;
        remotes.flathub = "https://flathub.org/repo/flathub.flatpakrepo";
        packages = [
            # Useful for accessing Windows VM(s?) or remote systems
            # maybe even GPU passthrough --> Windows --> GPU-PV --> multiple Windows guests w/ Sunshine
            # if only that setup didn't fucking crash Proxmox every ~5 minutes :(
            #"flathub:app/com.moonlight_stream.Moonlight//stable"
        ];
    };
}
