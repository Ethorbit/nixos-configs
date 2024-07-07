{ config, pkgs, ... }:

{
    imports = [
        ../../packages/rofi
        ../../packages/termdown-wrapper
    ];

    environment.systemPackages = with pkgs; [
        feh
        ranger
        trash-cli
        moc
        jq
        lm_sensors
        libnotify
        termdown
        config.ethorbit.pkgs.termdown-wrapper
    ];
}
