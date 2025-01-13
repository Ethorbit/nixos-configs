{ config, ... }:

{
    imports = [
        ./audio
        ./window-manager
        ./x.nix
        ./cpu.nix
        ./gpu.nix
        ./memory.nix
        ./date.nix
        ./lock.nix
        ./powermenu.nix
        ./battery.nix
        ./filesystem.nix
        ./network.nix
        ./microphone.nix
        ./weather.nix
    ];
}
