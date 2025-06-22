{ config, pkgs, ... }:

{
    programs.termdown-wrapper.enable = true;

    environment.systemPackages = with pkgs; [
        ranger
        trash-cli
        xdragon
        moc
        jq
        lm_sensors
        libnotify
        termdown
        ethorbit.mousejail
    ];
}
