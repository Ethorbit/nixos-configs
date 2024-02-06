{ config, ... }:

{
    imports = [
        ./gpu-temperature.nix
        ./gpu-usage.nix
        ./gpu.nix
        ./cpu-temperature.nix
        ./cpu-usage.nix
        ./cpu.nix
    ];
}
