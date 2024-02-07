{ config, ... }:

{
    imports = [
        ./music
        ./pulseaudio.nix
        ./alsa.nix
        ./scream.nix
    ];
}
