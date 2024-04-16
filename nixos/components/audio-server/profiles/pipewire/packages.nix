{ config, pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        pipewire
        pavucontrol
        
        # Since pulse support will be enabled
        # pulseaudio commands will be compatible
        # but to use them pulseaudio needs to
        # be installed too.
        pulseaudio
    ];
}
