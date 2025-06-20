{ config, pkgs, ... }:

{
    imports = [
        ../../nixos/packages/node/filen-cli
    ];

    environment.systemPackages = with pkgs; [
        libreoffice-qt
        keepassxc

        config.ethorbit.pkgs.node.filen-cli

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
