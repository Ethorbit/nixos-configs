{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        libreoffice-qt
        keepassxc

        ethorbit.filen-cli

        yt-dlp
        ethorbit.yt-dlp-wrapper

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
