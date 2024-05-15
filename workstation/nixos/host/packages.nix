{ config, pkgs, ... }:

{
    imports = [
        ../../../nixos/packages/yt-dlp-wrapper
    ];

    environment.systemPackages = with pkgs; [
        # weird ToolBar.qml error, I'll just install it as a Flatpak instead
        #moonlight-qt

        obs-studio
        keepassxc

        firefox

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
