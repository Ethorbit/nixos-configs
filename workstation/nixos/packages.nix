{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        # weird ToolBar.qml error, I'll just install it as a Flatpak instead
        #moonlight-qt
        
        obs-studio
        keepassxc
        firefox
    ];

    services.flatpak = {
        enable = true;
        remotes.flathub = "https://flathub.org/repo/flathub.flatpakrepo";
        packages = [
            "flathub:app/com.moonlight_stream.Moonlight//stable"
        ];
    };
}
