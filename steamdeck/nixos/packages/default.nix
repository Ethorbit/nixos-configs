{ config, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    environment.systemPackages = with pkgs; [
        cryptsetup
        onboard
        neofetch
        keepassxc
        yt-dlp
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
