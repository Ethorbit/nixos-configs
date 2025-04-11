{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/packages/node/filen-cli
        ../../nixos/packages/script/yt-dlp-wrapper
    ];

    environment.systemPackages = with pkgs; [
        libreoffice-qt
        keepassxc

        config.ethorbit.pkgs.node.filen-cli

        yt-dlp
        config.ethorbit.pkgs.script.yt-dlp-wrapper

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
