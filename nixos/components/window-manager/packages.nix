{ config, pkgs, ... }:

{
    imports = [
        ../../packages/script/termdown-wrapper
    ];

    environment.systemPackages = with pkgs; [
        ranger
        trash-cli
        xdragon
        moc
        jq
        lm_sensors
        libnotify
        termdown
        config.ethorbit.pkgs.script.termdown-wrapper
        ethorbit.mousejail
    ];
}
