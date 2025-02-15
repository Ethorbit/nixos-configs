{ config, pkgs, ... }:

{
    imports = [
        ./scripts
    ];

    environment.systemPackages = with pkgs; [
        neofetch
        keepassxc
        yt-dlp

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
    ];
}
