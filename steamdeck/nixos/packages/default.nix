{ config, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    environment.systemPackages = with pkgs; [
        onboard
        neofetch
        keepassxc
        yt-dlp

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
