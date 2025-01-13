{ config, ... }:

{
    imports = [
        ./nvidia
        ./amd
        ./audio
        ./launch.nix
        ./memory-available.nix
        ./microphone.nix
        ./weather.nix
        ./lock.nix
    ];
}
