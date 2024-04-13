{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # weird ToolBar.qml error, I'll just install it as a Flatpak instead
        #moonlight-qt

        obs-studio
        keepassxc

        # browsers shouldn't really be used on host if it can be helped
        firefox
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
