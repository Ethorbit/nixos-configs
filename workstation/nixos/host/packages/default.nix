{ config, pkgs, ... }:

{
    imports = [
        ./scripts
        ../../../../nixos/packages/yt-dlp-wrapper
        ../../../../nixos/packages/mount-sshfs-run-service
    ];

    programs.adb.enable = true;

    environment.systemPackages = with pkgs; [
        coturn

        # weird ToolBar.qml error, I'll just install it as a Flatpak instead
        #moonlight-qt
        neofetch

        libreoffice-qt

        virtiofsd
        virt-viewer

        obs-studio
        keepassxc

        filezilla
        sshfs

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

        # until the containers are up and running, everything will have to be done on host
        yt-dlp
        config.ethorbit.pkgs.yt-dlp-wrapper
        gimp
        kdenlive
        audacity
    ];

    services.flatpak = {
        enable = true;
        remotes.flathub = "https://flathub.org/repo/flathub.flatpakrepo";
        packages = [
            # Useful for accessing Windows VM(s?) or remote systems
            # maybe even GPU passthrough --> Windows --> GPU-PV --> multiple Windows guests w/ Sunshine
            # if only that setup didn't fucking crash Proxmox every ~5 minutes :(
            "flathub:app/com.moonlight_stream.Moonlight//stable"
        ];
    };
}
