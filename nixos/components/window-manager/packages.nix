{ config, pkgs, ... }:

{
    imports = [
        ../../packages/rofi
    ];
    
    environment.systemPackages = with pkgs; [
        feh
        moc
        jq
        lm_sensors
        libnotify
    ];
}
