{ config, pkgs, ... }:

{
    imports = [
        ../../packages/rofi
        ../../packages/script/termdown-wrapper
        ../../packages/mousejail
    ];

    environment.systemPackages = with pkgs; [
        feh
        ranger
        trash-cli
        xdragon
        moc
        jq
        lm_sensors
        libnotify
        termdown
        config.ethorbit.pkgs.script.termdown-wrapper
        config.ethorbit.pkgs.mousejail
    ];
}
