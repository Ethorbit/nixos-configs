{ config, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    environment.systemPackages = with pkgs; [
        cryptsetup
        distrobox
        onboard
        neofetch
        keepassxc
        yt-dlp
        ethorbit.yt-dlp-wrapper
        krita
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
    ];
}
