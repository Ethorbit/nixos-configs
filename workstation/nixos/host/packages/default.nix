{ config, pkgs, ... }:

{
    imports = [
        ./scripts
        ../../../../nixos/packages/yt-dlp-wrapper
        ../../../../nixos/packages/mount-sshfs-run-service
        ../../../../nixos/packages/godot4-mono
        ../../../../nixos/packages/node/filen-cli
        ../../../../nixos/packages/python/codebase-to-text
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

        config.ethorbit.pkgs.python.codebase-to-text
        config.ethorbit.pkgs.node.filen-cli
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
        # dotnet or godot4-mono cries.
        # I should really fix the package so it can access it on its own
        # but to be honest, I want to make a game now, not mess with nixos all day..
        dotnet-sdk
        #godot_4
        gimp
        kdenlive
        obs-studio

        # This system may use several TTY user desktops
        # startx is needed to accomplish that.
        xorg.xinit
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
