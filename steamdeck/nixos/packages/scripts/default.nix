{ config, ... }:

{
    imports = [
        ./decrypt
        ../../../../nixos/packages/script/yt-dlp-wrapper
    ];

    environment.systemPackages = [
        config.ethorbit.pkgs.script.yt-dlp-wrapper
    ];
}
