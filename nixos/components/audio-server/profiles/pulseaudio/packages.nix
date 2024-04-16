{ config, ... }:

{
    environment.systemPackages = with pkgs; [
        pulseaudio
        pavucontrol
    ];
}
