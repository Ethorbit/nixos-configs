{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        feh
        moc
        jq
        lm_sensors
    ];
}
