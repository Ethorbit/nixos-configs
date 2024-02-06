{ config, ... }:

{
    imports = [
        ./launch.nix
        ./nvidia
        ./amd
        ./mocp
        ./scream
        ./memory-available.nix
        ./microphone.nix
        ./weather.nix
    ];
}
