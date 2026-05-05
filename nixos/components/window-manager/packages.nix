{ config, pkgs, ... }:

{
    ethorbit.programs.termdown-wrapper.enable = true;

    environment.systemPackages = with pkgs; [
        ranger
        trash-cli
        dragon-drop
        moc
        jq
        lm_sensors
        libnotify
        termdown
        ethorbit.mousejail
    ];
}
